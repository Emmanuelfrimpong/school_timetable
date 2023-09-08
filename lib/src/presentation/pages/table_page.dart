import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/functions/time_functions.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import 'package:school_timetable/src/core/utils/text_style.dart';
import 'package:school_timetable/src/core/widgets/smart_dialog.dart';
import 'package:school_timetable/src/data/models/tables/table_model.dart';
import '../../core/constants/classes_constants.dart';
import '../../data/models/period_model.dart';
import '../riverpod/period_services.dart';
import '../riverpod/table_services.dart';
import '../widgets/day_item.dart';


class TablePage extends ConsumerStatefulWidget {
  const TablePage({super.key});
  @override
  ConsumerState<TablePage> createState() => _TablePageState();
}

class _TablePageState extends ConsumerState<TablePage> {
  @override
  Widget build(BuildContext context) {
    var tables = ref.watch(tableListProvider);
    var periods = ref.watch(periodDataProvider);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: LayoutBuilder(builder: (context, size) {
        if (tables.isEmpty) {
          //var periods = ref.watch(periodDataProvider);
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 2)),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            startTime: const TimeOfDay(hour: 7, minute: 0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods
                                  .where((element) => element.period == 1)
                                  .toList()
                                  .isNotEmpty &&
                              periods
                                      .where((element) => element.period == 1)
                                      .toList()[0]
                                      .startTime !=
                                  null &&
                              periods
                                      .where((element) => element.period == 1)
                                      .toList()[0]
                                      .endTime !=
                                  null)
                            periodItem(
                              period: 2,
                              context: context,
                              title: '2nd Period',
                              startTime: stringToTimeOfDay(periods
                                  .where((element) => element.period == 1)
                                  .toList()[0]
                                  .endTime!),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods
                                  .where((element) => element.period == 2)
                                  .toList()
                                  .isNotEmpty &&
                              periods
                                      .where((element) => element.period == 2)
                                      .toList()[0]
                                      .startTime !=
                                  null &&
                              periods
                                      .where((element) => element.period == 2)
                                      .toList()[0]
                                      .endTime !=
                                  null)
                            periodItem(
                              period: 3,
                              context: context,
                              title: '3rd Period',
                              startTime: stringToTimeOfDay(periods
                                  .where((element) => element.period == 2)
                                  .toList()[0]
                                  .endTime!),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods
                                  .where((element) => element.period == 3)
                                  .toList()
                                  .isNotEmpty &&
                              periods
                                      .where((element) => element.period == 3)
                                      .toList()[0]
                                      .startTime !=
                                  null &&
                              periods
                                      .where((element) => element.period == 3)
                                      .toList()[0]
                                      .endTime !=
                                  null)
                            periodItem(
                              period: 4,
                              context: context,
                              title: '4th Period',
                              startTime: stringToTimeOfDay(periods
                                  .where((element) => element.period == 3)
                                  .toList()[0]
                                  .endTime!),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods
                                  .where((element) => element.period == 4)
                                  .toList()
                                  .isNotEmpty &&
                              periods
                                      .where((element) => element.period == 4)
                                      .toList()[0]
                                      .startTime !=
                                  null &&
                              periods
                                      .where((element) => element.period == 4)
                                      .toList()[0]
                                      .endTime !=
                                  null)
                            periodItem(
                              period: 5,
                              context: context,
                              title: '5th Period',
                              startTime: stringToTimeOfDay(periods
                                  .where((element) => element.period == 4)
                                  .toList()[0]
                                  .endTime!),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods
                                  .where((element) => element.period == 5)
                                  .toList()
                                  .isNotEmpty &&
                              periods
                                      .where((element) => element.period == 5)
                                      .toList()[0]
                                      .startTime !=
                                  null &&
                              periods
                                      .where((element) => element.period == 5)
                                      .toList()[0]
                                      .endTime !=
                                  null)
                            periodItem(
                              period: 6,
                              context: context,
                              title: '6th Period',
                              startTime: stringToTimeOfDay(periods
                                  .where((element) => element.period == 5)
                                  .toList()[0]
                                  .endTime!),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods
                                  .where((element) => element.period == 6)
                                  .toList()
                                  .isNotEmpty &&
                              periods
                                      .where((element) => element.period == 6)
                                      .toList()[0]
                                      .startTime !=
                                  null &&
                              periods
                                      .where((element) => element.period == 6)
                                      .toList()[0]
                                      .endTime !=
                                  null)
                            periodItem(
                              period: 7,
                              context: context,
                              title: '7th Period',
                              startTime: stringToTimeOfDay(periods
                                  .where((element) => element.period == 6)
                                  .toList()[0]
                                  .endTime!),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Breaks'.toUpperCase(),
                            style: kTitleTextStyle(
                                size: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods.isNotEmpty)
                            periodItem(
                              period: 8,
                              context: context,
                              title: '1st Break',
                              startTime:
                                  stringToTimeOfDay(periods.last.endTime),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (periods
                                  .where((element) => element.period == 8)
                                  .toList()
                                  .isNotEmpty &&
                              periods
                                      .where((element) => element.period == 8)
                                      .toList()[0]
                                      .startTime !=
                                  null &&
                              periods
                                      .where((element) => element.period == 8)
                                      .toList()[0]
                                      .endTime !=
                                  null)
                            periodItem(
                              period: 9,
                              context: context,
                              title: '2nd Break',
                              startTime: stringToTimeOfDay(periods
                                  .where((element) => element.period == 8)
                                  .toList()[0]
                                  .endTime!),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  if (periods.isNotEmpty &&
                      periods.last.startTime != null &&
                      periods.last.endTime != null)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 25)),
                        onPressed: () {
                          // warn user
                          CustomDialog.showInfo(
                            title: 'Generate Table',
                            message: 'Are you sure you want to generate table?',
                            onConfirmText: 'Generate',
                            onConfirm: () {
                              ref
                                  .read(tableListProvider.notifier)
                                  .generateTables(ref);
                            },
                          );
                        },
                        child: Text(
                          'Generate Table',
                          style: kTitleTextStyle(
                              color: Colors.white,
                              size: 22,
                              fontWeight: FontWeight.bold),
                        )),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Tables'.toUpperCase(),
                    style:
                        kTitleTextStyle(size: 25, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        // warn user
                        CustomDialog.showInfo(
                          title: 'Generate Table',
                          message: 'Are you sure you want to generate table?',
                          onConfirmText: 'Generate',
                          onConfirm: () {
                            ref
                                .read(tableListProvider.notifier)
                                .generateTables(ref);
                          },
                        );
                      },
                      icon: const Icon(Icons.refresh)),
                      ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: (){
                    CustomDialog.showSuccess(title: 'Export to PDF', message: 'Unable to export to PDF, This feature is not yet available');
                  }, child: const Text('Export to PDF', style: TextStyle(color: Colors.white),))
                //time picker
                ],
              ),
              Expanded(
                  child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: TablesWidget(
                        table: tables,
                        periods: periods,
                      ))),
            ],
          );
        }
      }),
    );
  }

  Row periodItem(
      {required BuildContext context,
      required String title,
      required TimeOfDay startTime,
      required int period}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //check box
        Checkbox(
            activeColor: primaryColor,
            side: const BorderSide(color: primaryColor),
            value: ref
                .watch(periodDataProvider)
                .where((element) => element.period == period)
                .isNotEmpty,
            onChanged: (value) {
              if (value!) {
                ref
                    .read(periodDataProvider.notifier)
                    .addPeriod(PeriodModel(period: period, periodName: title));
              } else {
                ref.read(periodDataProvider.notifier).removePeriod(ref
                    .watch(periodDataProvider)
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
          style: kTitleTextStyle(size: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 20,
        ),
        if (ref
            .watch(periodDataProvider)
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
                    text: ref
                            .watch(periodDataProvider)
                            .where((element) => element.period == period)
                            .toList()[0]
                            .startTime ??
                        '',
                    style: kTitleTextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        size: 17),
                  ),
                ])),
                const SizedBox(
                  width: 25,
                ),
                IconButton(
                    onPressed: () async {
                      final TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: startTime,
                      );
                      if (newTime != null) {
                        //get period
                        var Item = ref
                            .watch(periodDataProvider)
                            .where((element) => element.period == period)
                            .toList()
                            .first;
                        Item.startTime = timeOfDayToString(newTime);
                        //remove and add period
                        ref
                            .read(periodDataProvider.notifier)
                            .removePeriod(Item);
                        ref.read(periodDataProvider.notifier).addPeriod(Item);
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
                    text: ref
                            .watch(periodDataProvider)
                            .where((element) => element.period == period)
                            .toList()[0]
                            .endTime ??
                        '',
                    style: kTitleTextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        size: 17),
                  ),
                ])),

                const SizedBox(
                  width: 25,
                ),
                IconButton(
                    onPressed: () async {
                      final TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: startTime,
                      );
                      if (newTime != null) {
                        //get period
                        var item = ref
                            .watch(periodDataProvider)
                            .where((element) => element.period == period)
                            .toList()
                            .first;
                        item.endTime = timeOfDayToString(newTime);
                        //remove and add period
                        ref
                            .read(periodDataProvider.notifier)
                            .removePeriod(item);
                        ref.read(periodDataProvider.notifier).addPeriod(item);
                      }
                    },
                    icon: const Icon(Icons.calendar_month)),
                const SizedBox(
                  width: 25,
                ),
                
              ],
            ),
          ),

        // add start and end time picker
      ],
    );
  }
}

class TablesWidget extends StatelessWidget {
  const TablesWidget({super.key, required this.table, required this.periods});
  final List<TableModel> table;
  final List<PeriodModel> periods;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: days.map((e) {
          var data1 = table.where((element) => element.day == e);
          if (data1.isEmpty) {
            return Container();
          }
          return DayItem(
            day: e,
            periods: periods,
            tables: table
                .where(
                    (element) => element.day!.toLowerCase() == e.toLowerCase())
                .toList(),
          );
        }).toList(),
      ),
    );
  }
}
