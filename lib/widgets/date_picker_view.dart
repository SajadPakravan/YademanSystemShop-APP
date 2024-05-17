import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class DatePickerView extends StatefulWidget {
  const DatePickerView({super.key, required this.onChange});

  final Function(String) onChange;

  @override
  State<DatePickerView> createState() => _DatePickerViewState();
}

class _DatePickerViewState extends State<DatePickerView> {
  List<String> yearLst = [];
  List<String> monthLst = [];
  List<String> dayLst = [];
  int selectedDay = 0;
  int selectedMonth = 0;
  int selectedYear = 0;

  yearList() {
    List<String> listYear = [];
    for (int i = 1330; i <= Jalali.now().year; i++) {
      listYear.add(i.toString());
    }
    return listYear;
  }

  monthList() {
    List<String> list = [
      "فروردین",
      "اردیبهشت",
      "خرداد",
      "تیر",
      "مرداد",
      "شهریور",
      "مهر",
      "آبان",
      "آذر",
      "دی",
      "بهمن",
      "اسفند",
    ];
    return list;
  }

  dayList() {
    List<String> list = [];
    for (int i = 1; i <= 30; i++) {
      list.add(i.toString());
    }
    return list;
  }

  @override
  void initState() {
    dayLst = dayList();
    monthLst = monthList();
    yearLst = yearList();
    selectedDay = Jalali.now().day - 1;
    selectedMonth = Jalali.now().month - 1;
    selectedYear = yearLst.length - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          pickerView(
            list: dayLst,
            selected: selectedDay,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedDay = index;
                onChangePicker();
              });
            },
          ),
          const SizedBox(width: 40),
          pickerView(
            list: monthLst,
            selected: selectedMonth,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedMonth = index;
                onChangePicker();
              });
            },
          ),
          const SizedBox(width: 40),
          pickerView(
            list: yearLst,
            selected: selectedYear,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedYear = index;
                onChangePicker();
              });
            },
          ),
        ],
      ),
    );
  }

  pickerView({required List<String> list, required int selected, required Function(int) onSelectedItemChanged}) {
    return Expanded(
      child: CupertinoPicker.builder(
        itemExtent: 40,
        childCount: list.length,
        scrollController: FixedExtentScrollController(initialItem: selected),
        onSelectedItemChanged: onSelectedItemChanged,
        itemBuilder: (context, index) {
          return Center(child: Text(list[index].toPersianDigit(), style: Theme.of(context).textTheme.bodyMedium));
        },
      ),
    );
  }

  onChangePicker() {
    int y = int.parse(yearLst[selectedYear]);
    int m = selectedMonth + 1;
    widget.onChange('$y-$m-${selectedDay + 1}');
  }
}
