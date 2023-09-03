import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/functions/time_functions.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import 'package:school_timetable/src/core/utils/text_style.dart';

import '../../data/models/period_model.dart';
import '../riverpod/period_services.dart';
import '../riverpod/table_services.dart';

class TablePage extends ConsumerStatefulWidget {
  const TablePage({super.key});
  @override
  ConsumerState<TablePage> createState() => _TablePageState();
}

class _TablePageState extends ConsumerState<TablePage> {
  @override
  Widget build(BuildContext context) {
    var tables = ref.watch(tableListProvider);

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: LayoutBuilder(builder: (context, size) {
        if (tables.isEmpty) {
          var periods = ref.watch(periodDataProvider);
          return Center(
            child: Row(children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2)),
                child: Column(
                  children: [
                    Text(
                      'Periods'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    periodItem(
                      period: 1,
                      context: context,
                      title: '1st Period',
                      periods: periods
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    periodItem(
                      period: 2,
                      context: context,
                      title: '2nd Period',
                      periods: periods
                    ),
                     const SizedBox(
                      height: 10,
                    ),
                    
                    

                  ],
                ),
              )),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2)),
                child: Column(
                  children: [
                    Text(
                      'Breaks'.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '1st Break :',
                          style: kTitleTextStyle(
                              size: 18, fontWeight: FontWeight.bold),
                        ),
                        // add start and end time picker
                      ],
                    )
                  ],
                ),
              ))
            ]),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Row periodItem({required List<PeriodModel> periods, required BuildContext context, required String title,required int period }) {
    return Row(
                    children: [
                      //check box
                      Checkbox(
                          activeColor: primaryColor,
                          side: const BorderSide(color: primaryColor),
                          value: periods
                              .where((element) => element.period == period)
                              .isNotEmpty,
                          onChanged: (value) {
                            if (value!) {
                              ref
                                  .read(periodDataProvider.notifier)
                                  .addPeriod(PeriodModel(
                                    period: period,
                                  ));
                            } else {
                              ref
                                  .read(periodDataProvider.notifier)
                                  .removePeriod(periods
                                      .where((element) => element.period == period)
                                      .toList()
                                      .first);
                            }
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        style: kTitleTextStyle(
                            size: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (periods
                          .where((element) => element.period == period)
                          .toList()
                          .isNotEmpty)
                        Expanded(
                          child: Row(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'Start :\t\t',
                                  style: kTitleTextStyle(),
                                ),
                                TextSpan(
                                  text: periods
                                          .where((element) =>
                                              element.period == period)
                                          .toList()[0]
                                          .startTime ??
                                      '',
                                  style: kTitleTextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      size: 17),
                                ),
                              ])),

                              IconButton(
                                  onPressed: () async {
                                    final TimeOfDay? newTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: const TimeOfDay(
                                          hour: 7, minute: 00),
                                    );
                                    if (newTime != null) {
                                      //get period
                                      var Item = periods
                                          .where((element) =>
                                              element.period == period)
                                          .toList()
                                          .first;
                                      Item.startTime =
                                          timeOfDayToString(newTime);
                                      //remove and add period
                                      ref
                                          .read(periodDataProvider.notifier)
                                          .removePeriod(Item);
                                      ref
                                          .read(periodDataProvider.notifier)
                                          .addPeriod(Item);
                                    }
                                  },
                                  icon: const Icon(Icons.calendar_month)),
                              const SizedBox(
                                width: 25,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'End Time :\t\t',
                                  style: kTitleTextStyle(),
                                ),
                                TextSpan(
                                  text: periods
                                          .where((element) =>
                                              element.period == period)
                                          .toList()[0]
                                          .endTime ??
                                      '',
                                  style: kTitleTextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      size: 17),
                                ),
                              ])),

                              IconButton(
                                  onPressed: () async {
                                    final TimeOfDay? newTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: const TimeOfDay(
                                          hour: 7, minute: 00),
                                    );
                                    if (newTime != null) {
                                      //get period
                                      var item = periods
                                          .where((element) =>
                                              element.period == period)
                                          .toList()
                                          .first;
                                      item.endTime =
                                          timeOfDayToString(newTime);
                                      //remove and add period
                                      ref
                                          .read(periodDataProvider.notifier)
                                          .removePeriod(item);
                                      ref
                                          .read(periodDataProvider.notifier)
                                          .addPeriod(item);
                                    }
                                  },
                                  icon: const Icon(Icons.calendar_month)),
                              //time picker
                            ],
                          ),
                        ),

                      // add start and end time picker
                    ],
                  );
  }
}
