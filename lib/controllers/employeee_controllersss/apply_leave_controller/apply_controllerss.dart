import 'package:get/get.dart';

class CalendarController extends GetxController {
  late CalendarController _calendarController;
  List<DateTime> _selectedDates = [];

  @override
  void onInit() {
    super.onInit();
    _calendarController = CalendarController();
  }

  @override
  void onClose() {
    _calendarController.dispose();
    super.onClose();
  }

  void onDaySelected(DateTime date) {
    if (_selectedDates.contains(date)) {
      _selectedDates.remove(date);
    } else {
      _selectedDates.add(date);
    }
    update();
  }

  // void sendSelectedDates() {
  //   ApiService().sendDates(_selectedDates);
  // }

  CalendarController get calendarController => _calendarController;
}
