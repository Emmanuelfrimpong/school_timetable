import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/constants/teacher_constant.dart';
import 'package:school_timetable/src/data/DataSources/teacher_data_source.dart';
import 'package:school_timetable/src/presentation/riverpod/teachers_services.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/text_style.dart';
import '../../core/widgets/custom_input.dart';
import '../../core/widgets/custom_table.dart';
import '../../core/widgets/smart_dialog.dart';

class TeachersPage extends ConsumerStatefulWidget {
  const TeachersPage({super.key});

  @override
  ConsumerState<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends ConsumerState<TeachersPage> {
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  @override
  Widget build(BuildContext context) {
     var teacherList = ref.watch(filteredTeacherListProvider);
    var selectedTeacher = ref.watch(selectedTeacherProvider);
    return LayoutBuilder(builder: (context, size){
return  Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    'Teachers',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const SizedBox(width: 100),
                  Expanded(
                    child: CustomTextFields(
                      hintText: 'Search Teachers',
                      suffixIcon: const Icon(
                        Icons.search,
                        color: primaryColor,
                      ),
                      onChanged: (value) {
                        ref.read(teacherSearchProvider.notifier).state = value;
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
                            'Import Teachers',
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
                                .read(teacherImportProvider.notifier)
                                .importTeachers(ref);
                            break;
                          case 'download':
                            ref
                                .read(teacherImportProvider.notifier)
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
                                      .read(teachersListProvider.notifier)
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
                                .read(teacherImportProvider.notifier)
                                .importTeachers(ref);
                          },
                          child: const Text('Import Teacher'),
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
                                .read(teacherImportProvider.notifier)
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
                                      .read(teachersListProvider.notifier)
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
              if (teacherList.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No Teacher Added Yet',
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
                    border: teacherList.isNotEmpty
                        ? const TableBorder(
                            horizontalInside:
                                BorderSide(color: Colors.grey, width: 1),
                            top: BorderSide(color: Colors.grey, width: 1),
                            bottom: BorderSide(color: Colors.grey, width: 1))
                        : const TableBorder(),
                    dataRowHeight: 45,
                    source: TeacherDataSource(ref),
                    rowsPerPage: 10,
                    showFirstLastButtons: true,
                    columns: teacherColumns
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
                                        selectedTeacher.isEmpty
                                            ? Icons.check_box_outline_blank
                                            : selectedTeacher.length ==
                                                    teacherList.length
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