
import 'package:flutter/material.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import 'package:school_timetable/src/core/utils/text_style.dart';
import 'package:school_timetable/src/data/models/tables/table_model.dart';

class TableItem extends StatefulWidget {
  const TableItem({super.key, this.table});

  final TableModel? table;

  @override
  State<TableItem> createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 260,
        height: 100,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        alignment:
            widget.table == null ? Alignment.centerLeft : Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: widget.table == null
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            if (widget.table != null)
              Text(
                widget.table!.subject!,
                style:kTitleTextStyle(
                    size: 15,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            if (widget.table != null)
              Text(
                '(${widget.table!.classCode!})',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: kTitleTextStyle(
                    size: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            if (widget.table != null)
              Text(
                '-${widget.table!.teacherName!}-',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kTitleTextStyle(
                    size: 12,
                    color: primaryColor.withOpacity(.5),
                    fontWeight: FontWeight.bold),
              ),
          ],
        ));
  }
}
