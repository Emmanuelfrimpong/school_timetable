import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import '../../presentation/riverpod/navigation_services.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = ref.watch(sidebarWidthProvider);

    return Container(
      width: width,
      color: primaryColor,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 20),
            SideBarItem(
              width: width,
              icon: Icons.menu,
              onTap: () {
                if (width == 60) {
                  ref.read(sidebarWidthProvider.notifier).state = 200;
                } else {
                  ref.read(sidebarWidthProvider.notifier).state = 60;
                }
              },
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SideBarItem(
                  width: width,
                  icon: Icons.school,
                  title: 'Classes',
                  onTap: () {
                    ref.read(mainPageNavigationProvider.notifier).state = 0;
                  },
                  isSelected: ref.watch(mainPageNavigationProvider) == 0,
                ),
                SideBarItem(
                  width: width,
                  icon: Icons.person,
                  title: 'Teachers',
                  onTap: () {
                    ref.read(mainPageNavigationProvider.notifier).state = 1;
                  },
                  isSelected: ref.watch(mainPageNavigationProvider) == 1,
                ),
                SideBarItem(
                  width: width,
                  icon: Icons.table_view_outlined,
                  title: 'Tables',
                  onTap: () {
                    ref.read(mainPageNavigationProvider.notifier).state = 2;
                  },
                  isSelected: ref.watch(mainPageNavigationProvider) == 2,
                ),
              ],
            ))
          ]),
    );
  }
}

class SideBarItem extends StatefulWidget {
  const SideBarItem({
    super.key,
    required this.width,
    required this.icon,
    this.title,
    required this.onTap,
    this.isSelected = false,
  });

  final double width;
  final IconData icon;
  final String? title;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (state) {
        setState(() {
          onHover = state;
        });
      },
      child: widget.title!=null?
      Container(
        height: 60,
        width: widget.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: widget.width == 60 ? 10 : 20),
        color: onHover
            ? secondaryColor.withOpacity(0.2)
            : widget.isSelected
                ? secondaryColor
                : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
                color: onHover
                    ? secondaryColor
                    : widget.isSelected
                        ? primaryColor
                        : secondaryColor,
                size: 30,
                widget.icon),
            if (widget.width == 200 && widget.title != null)
              const SizedBox(width: 20),
            if (widget.width == 200 && widget.title != null)
              Text(
                widget.title!,
                style: TextStyle(
                    color: onHover
                        ? secondaryColor
                        : widget.isSelected
                            ? primaryColor
                            : secondaryColor,
                    fontSize: 20),
              ),
               const Spacer(),
          ],
        ),
      ):
      Row(
        mainAxisAlignment:widget.width == 60? MainAxisAlignment.center: MainAxisAlignment.end,
        children: [
          Icon(
                  color: onHover
                      ? secondaryColor
                      : widget.isSelected
                          ? primaryColor
                          : secondaryColor,
                  size: 30,
                  widget.icon),
                  const SizedBox(width: 20),
        ],
      )
    );
  }
}
