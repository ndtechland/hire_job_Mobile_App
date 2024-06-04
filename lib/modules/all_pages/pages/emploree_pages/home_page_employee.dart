import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/emploree_pages/side_drower.dart';

import '../../../../components/responsive_text.dart';

class HomeEmployee extends StatelessWidget {
  final RxBool isLoading = false.obs;

  static const String id = 'Categories';

  final List<String> image = [
    'lib/assets/images/totalleave.png',
    'lib/assets/images/available_attandance.png',
    'lib/assets/images/totalleave.png',
    'lib/assets/images/monthsLeaves.png',
    'lib/assets/images/salaryslip.png',
    'lib/assets/images/c2.png',
    // 'lib/assets/images/c3.png',
    // 'lib/assets/images/c4.png',
  ];

  final List<String> name = [
    'Total Leaves',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6',
  ];

  // Colors for images and containers
  final List<Color> imageColors = [
    Color(0xffee6c4d),
    Colors.yellow,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    //Colors.pink,
  ];

  final List<Color> containerColors = [
    Color(0xffee6c4d),
    Colors.cyan,
    Colors.deepOrange,
    Colors.amber.shade700,
    Colors.lime.shade700,
    Colors.indigo,
  ];

  HomeEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: EmployeeNavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Hired Employee'),
        centerTitle: true,
        titleSpacing: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
        ],
        flexibleSpace: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[logoColor, logoColor]),
          ),
        ),
        elevation: 0,
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return LayoutBuilder(builder: (context, constraints) {
          var screenWidth = constraints.maxWidth;
          var screenHeight = constraints.maxHeight;

          var imageWidth = orientation == Orientation.portrait
              ? screenWidth * 0.55
              : screenWidth * 0.25;
          var imageHeight = orientation == Orientation.portrait
              ? screenHeight * 0.2
              : screenHeight * 0.5;

          var imageWidth2 = orientation == Orientation.portrait
              ? screenWidth * 0.55
              : screenWidth * 0.19;
          var imageHeight2 = orientation == Orientation.portrait
              ? screenHeight * 0.32
              : screenHeight * 0.5;

          var categoryWidth = orientation == Orientation.portrait
              ? screenWidth * 0.5
              : screenWidth * 0.3;
          var categoryHeight = orientation == Orientation.portrait
              ? screenHeight * 0.12
              : screenHeight * 0.37;

          return Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                      mainAxisExtent: imageHeight2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: name.length,
                    itemBuilder: (context, index) {
                      final category = name[index];
                      return GestureDetector(
                        onTap: () {
                          //Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //   builder: (context) => const CompanyDetail(),
                          // ),
                          //);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                containerColors[index % containerColors.length],
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                color: Color.fromRGBO(0, 0, 0, 0.16),
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 1,
                                right: imageWidth * 0.01,
                                child: Container(
                                  height: imageHeight * 0.5,
                                  width: imageWidth * 0.3,
                                  child: image[index] != null
                                      ? Image.asset(
                                          image[index],
                                          // color: imageColors[
                                          //     index % imageColors.length],
                                          // fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'lib/assets/logo/noimageavlble.jpg',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.network(
                                          'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    responsiveText(
                                      context: context,
                                      text: (name[index]),
                                      fontSizePortrait: 10,
                                      fontSizeLandscape: 17,
                                      color: Colors.white,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: imageHeight2 * 0.45,
                                        width: imageWidth2 * 0.6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(100),
                                          ),
                                        ),
                                        child: Center(
                                          child: responsiveText(
                                            context: context,
                                            text: (name[index]),
                                            fontSizePortrait: 10,
                                            fontSizeLandscape: 17,
                                            color: containerColors[
                                                index % containerColors.length],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
      }),
    );
  }
}
