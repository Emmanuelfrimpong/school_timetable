// ignore_for_file: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/functions/time_functions.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import 'package:school_timetable/src/core/utils/text_style.dart';
import 'package:school_timetable/src/data/models/tables/table_model.dart';
import '../../data/models/period_model.dart';
import 'table_item.dart';


class DayItem extends ConsumerStatefulWidget {
  const DayItem({super.key, required this.tables, this.day, this.periods});
  final List<TableModel> tables;
  final String? day;
  final List<PeriodModel>? periods;

  @override
  ConsumerState<DayItem> createState() => _DayItemState();
}

class _DayItemState extends ConsumerState<DayItem> {
  List<TableModel> data = [];
  List<PeriodModel> section1 = [];
  List<PeriodModel> section2 = [];
  List<PeriodModel> section3 = [];
  List<PeriodModel>? breaks;
  PeriodModel? firstBreak;
  PeriodModel? secondBreak;
  Future<List<PeriodModel>> workOnPeriod() async {
    data= widget.tables;
    var periods = widget.periods;
    if (periods != null) {
      section1 = [];
      section2 = [];
      section3 = [];

      periods.sort((a, b) {       
        TimeOfDay aTime =stringToTimeOfDay(a.startTime!);
        TimeOfDay bTime = stringToTimeOfDay(b.startTime!);
        return aTime.hour.compareTo(bTime.hour);
      });

      //split periods at where breakTime is

      breaks = periods.where((element) =>
          element.periodName!.toString().toLowerCase().contains('break')).toList();
           firstBreak = breaks!.firstWhereOrNull((element) => element.period==8);
           secondBreak = breaks!.firstWhereOrNull((element) => element.period==9);
           //remove breaks from periods
          // get all periods before first break
          section1 = periods.where((element) {
            var elementTime = stringToTimeOfDay(element.startTime!);
            var breakTime = stringToTimeOfDay(firstBreak!.startTime!);
            return elementTime.hour < breakTime.hour;
          }).toList();
          // get all periods between first and second break
          section2 = periods.where((element) {
            var elementTime = stringToTimeOfDay(element.startTime!);
            var breakTime = stringToTimeOfDay(firstBreak!.endTime!);
            var secondBreakTime = stringToTimeOfDay(secondBreak!.startTime!);
            return elementTime.hour >= breakTime.hour && elementTime.hour < secondBreakTime.hour;
          }).toList();

          // get all periods after second break
          section3 = periods.where((element) {
            var elementTime = stringToTimeOfDay(element.startTime!);
            var secondBreakTime = stringToTimeOfDay(secondBreak!.endTime!);
            return elementTime.hour >= secondBreakTime.hour;
          }).toList();
      
    }

    // let print the first and second periods

    return periods!;
  }

  @override
  void initState() {
    super.initState();
    workOnPeriod();
  }

  @override
  Widget build(BuildContext context) {
      
      //print monday data 
      if(widget.day=='Monday'){
        print('Monday from View========================================');
        data.forEach((element) {
          print(element.period);
        });
        print('Monday from View End========================================');
      }
      //data.shuffle();
      return FutureBuilder<List<PeriodModel>>(
          future: workOnPeriod(),
          builder: (context, snapshot) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.day!,
                            style: kTitleTextStyle(
                                fontWeight: FontWeight.w600,
                                size: 25,
                                color: primaryColor)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Row(
                              children: [
                                if (section1.isNotEmpty)
                                  Row(
                                    children: section1
                                        .map((e) => Container(
                                              width: 260,
                                              height: 70,
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(e.periodName!,
                                                      style:
                                                         kTitleTextStyle(
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  Text(
                                                      '${e.startTime} - ${e.endTime}',
                                                      style:
                                                         kTitleTextStyle(
                                                              size: 15,
                                                              color: Colors
                                                                  .black)),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                if (firstBreak != null)
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(color: Colors.black),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 2),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(firstBreak!.startTime!,
                                            style:kTitleTextStyle(
                                                size: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        Text(firstBreak!.endTime!,
                                            style: kTitleTextStyle(
                                                size: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                if (section2.isNotEmpty)
                                  Row(
                                    children: section2
                                        .map((e) => Container(
                                              width: 260,
                                              height: 70,
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(e.periodName!,
                                                      style:
                                                          kTitleTextStyle(
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  Text(
                                                      '${e.startTime} - ${e.endTime}',
                                                      style:
                                                         kTitleTextStyle(
                                                              size: 15,
                                                              color: Colors
                                                                  .black)),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                   if (secondBreak != null)
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        top: BorderSide(color: Colors.black),
                                        bottom: BorderSide(
                                            color: Colors.black, width: 2),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(secondBreak!.startTime!,
                                            style:kTitleTextStyle(
                                                size: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        Text(secondBreak!.endTime!,
                                            style: kTitleTextStyle(
                                                size: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                               
                                   if (section3.isNotEmpty)
                                  Row(
                                    children: section3
                                        .map((e) => Container(
                                              width: 260,
                                              height: 70,
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(e.periodName!,
                                                      style:
                                                          kTitleTextStyle(
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  Text(
                                                      '${e.startTime} - ${e.endTime}',
                                                      style:
                                                         kTitleTextStyle(
                                                              size: 15,
                                                              color: Colors
                                                                  .black)),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                              
                              ],
                            )
                          ],
                        ),
                        if (widget.tables.isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [                             
                              if (section1.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                    var newData=data.where((element) => section1.contains(PeriodModel.fromMap(element.periodMap!))).toList();
                                    return Column(
                                      children: data.where((element) => section1.contains(PeriodModel.fromMap(element.periodMap!))).toList()
                                          .map(
                                            (venue) => Row(
                                              children: section1.map((period) {
                                                var table = newData
                                                    .firstWhereOrNull((element) =>                                                  
                                                        element.period ==
                                                            period.period);
                                                if (table != null) {
                                                  newData.remove(table);
                                                  return TableItem(
                                                    table: table,
                                                  );
                                                } else {
                                                  return const TableItem();
                                                }
                                              }).toList(),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  }
                                ),
                              if (firstBreak != null)
                                SizedBox(
                                  width: 90,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(
                                            'BREAK',
                                            style:kTitleTextStyle(
                                                size: 40,
                                                color: Colors.black,
                                               
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (section2.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                     var newData=data.where((element) => section2.contains(PeriodModel.fromMap(element.periodMap!))).toList();
                                    return Column(
                                      children: data.where((element) => section2.contains(PeriodModel.fromMap(element.periodMap!))).toList()
                                          .map(
                                            (venue) => Row(
                                              children: section2.map((period) {
                                                var table = newData
                                                    .firstWhereOrNull((element) =>
                                                       
                                                        element.period ==
                                                            period.period);
                                                if (table != null) {
                                                  newData.remove(table);
                                                  return TableItem(
                                                    table: table,
                                                  );
                                                } else {
                                                  return const TableItem();
                                                }
                                              }).toList(),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  }
                                ),
                            
                              if (secondBreak != null)
                                SizedBox(
                                  width: 90,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(
                                            'BREAK',
                                            style:kTitleTextStyle(
                                                size: 40,
                                                color: Colors.black,
                                               
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                               if (section3.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                     var newData=data.where((element) => section3.contains(PeriodModel.fromMap(element.periodMap!))).toList();
                                    return Column(
                                      children: data.where((element) => section3.contains(PeriodModel.fromMap(element.periodMap!))).toList()
                                          .map(
                                            (venue) => Row(
                                              children: section3.map((period) {
                                                var table = newData
                                                    .firstWhereOrNull((element) =>                                                  
                                                        element.period ==
                                                            period.period);
                                                if (table != null) {
                                                  newData.remove(table);
                                                  return TableItem(
                                                    table: table,
                                                  );
                                                } else {
                                                  return const TableItem();
                                                }
                                              }).toList(),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  }
                                ),                            
                            ],
                          )
                      ]),
                ),
              ),
            );
          });

  }
}
