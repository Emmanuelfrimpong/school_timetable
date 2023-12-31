import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/constants/classes_constants.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import 'package:school_timetable/src/core/utils/text_style.dart';
import 'package:school_timetable/src/core/widgets/custom_input.dart';
import '../../core/widgets/custom_table.dart';
import '../../core/widgets/smart_dialog.dart';
import '../../data/DataSources/classes_data_sources.dart';
import '../riverpod/classes_services.dart';

class ClassesPage extends ConsumerStatefulWidget {
  const ClassesPage({super.key});

  @override
  ConsumerState<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends ConsumerState<ClassesPage> {
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    var classesList = ref.watch(filteredClassListProvider);
    var selectedClasses = ref.watch(selectedClassProvider);
    return LayoutBuilder(builder: (context, size) {
      return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Classes',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const SizedBox(width: 100),
                  Expanded(
                    child: CustomTextFields(
                      hintText: 'Search Class',
                      suffixIcon: const Icon(
                        Icons.search,
                        color: primaryColor,
                      ),
                      onChanged: (value) {
                        ref.read(classSearchProvider.notifier).state = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 100),
                  if (size.maxWidth < 1000)
                    //show a popup menu button
                    PopupMenuButton(
                      icon: const Icon(
                        Icons.apps,
                        color: primaryColor,
                      ),
                      color: secondaryColor,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'import',
                          child: Text(
                            'Import Class',
                            style: kTitleTextStyle(),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'download',
                          child: Text(
                            'Download Template',
                            style: kTitleTextStyle(),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'clear',
                          child: Text(
                            'Clear All',
                            style: kTitleTextStyle(),
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'import':
                            ref
                                .read(classesImportProvider.notifier)
                                .importClasses(ref);
                            break;
                          case 'download':
                            ref
                                .read(classesImportProvider.notifier)
                                .downloadTemplate();
                            break;
                          case 'clear':
                            CustomDialog.showInfo(
                                title: 'Clear All',
                                message:
                                    'Are you sure you want to clear all classes?',
                                onConfirmText: 'Clear All',
                                onConfirm: () {
                                  ref
                                      .read(classesListProvider.notifier)
                                      .clear();
                                });

                            break;
                        }
                      },
                    ),
                  if (size.maxWidth >= 1000)
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(classesImportProvider.notifier)
                                .importClasses(ref);
                          },
                          child: const Text('Import Class'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(classesImportProvider.notifier)
                                .downloadTemplate();
                          },
                          child: const Text('Download Template'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            CustomDialog.showInfo(
                                title: 'Clear All',
                                message:
                                    'Are you sure you want to clear all classes?',
                                onConfirmText: 'Clear All',
                                onConfirm: () {
                                  ref
                                      .read(classesListProvider.notifier)
                                      .clear();
                                });
                          },
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                ],
              ),
              const Divider(
                color: primaryColor,
                thickness: 2,
              ),
              const SizedBox(height: 20),
              if (classesList.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No Classes Added Yet',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ),
                )
              else
                Expanded(
                  child: CustomTable(
                    arrowHeadColor: Colors.black,
                    dragStartBehavior: DragStartBehavior.start,
                    controller: _scrollController,
                    controller2: _scrollController2,
                    showCheckboxColumn: false,
                    border: classesList.isNotEmpty
                        ? const TableBorder(
                            horizontalInside:
                                BorderSide(color: Colors.grey, width: 1),
                            top: BorderSide(color: Colors.grey, width: 1),
                            bottom: BorderSide(color: Colors.grey, width: 1))
                        : const TableBorder(),
                    dataRowHeight: 45,
                    source: ClassesDataSource(ref),
                    rowsPerPage: 10,
                    showFirstLastButtons: true,
                    columns: classesColumns
                        .map((e) => DataColumn(
                              label: e.isNotEmpty
                                  ? Text(
                                      e,
                                      style: kTitleTextStyle(
                                        fontWeight: FontWeight.bold,
                                        size: 17,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        selectedClasses.isEmpty
                                            ? Icons.check_box_outline_blank
                                            : selectedClasses.length ==
                                                    classesList.length
                                                ? Icons.check_box
                                                : Icons.indeterminate_check_box,
                                      )),
                            ))
                        .toList(),
                  ),
                )
            ],
          ));
    });
  }
}
