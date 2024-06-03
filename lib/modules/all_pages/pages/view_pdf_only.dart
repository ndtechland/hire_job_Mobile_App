import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfViewerPage extends StatefulWidget {
  final File file;
  final String url;

  const PdfViewerPage({
    Key? key,
    required this.file,
    required this.url,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          if (widget.url.isNotEmpty)
            IconButton(
              onPressed: () async {
                bool success = await saveFile(widget.url, basename(widget.url));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Successfully saved to internal storage "PDF_Download" folder'
                          : 'Failed to save the file',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.download_rounded),
            ),
        ],
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        File saveFile = File('${directory.path}/$fileName');
        if (kDebugMode) {
          print('Saving file to: ${saveFile.path}');
        }

        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          await saveFile.writeAsBytes(bytes, flush: true);
          if (kDebugMode) {
            print('File saved successfully: ${saveFile.path}');
          }

          // Open file explorer with the specific file
          /// await OpenFile.open(saveFile.path);

          return true;
        } else {
          if (kDebugMode) {
            print('Failed to download file: ${response.statusCode}');
          }
          return false;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving file: $e');
      }
      return false;
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }
}
