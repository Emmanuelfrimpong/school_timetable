import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/generated/assets.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import 'package:school_timetable/src/presentation/pages/classes_page.dart';
import 'package:school_timetable/src/presentation/pages/table_page.dart';
import 'package:school_timetable/src/presentation/pages/teachers_page.dart';
import 'package:school_timetable/src/presentation/riverpod/navigation_services.dart';
import 'package:school_timetable/src/presentation/riverpod/timer_services.dart';
import 'package:window_manager/window_manager.dart';

import '../core/functions/warn_before_close.dart';
import '../core/widgets/side_bar.dart';


class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final pageIndexProvider = ref.watch(mainPageNavigationProvider);
    final timer= ref.watch(currentTimeStream);
    return WillPopScope(
      onWillPop: () async {
      //warn user with a dialog before closing the app
        return await onClose(context);   
      },
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: DragToMoveArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DragToMoveArea(
                child: Container(
                  
                  color: primaryColor,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(children: [
                    Image.asset(Assets.assetsLogoWhite,height: 35,),
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       timer.when(
                         error: (error, stackTrace) => Text(error.toString(), style: const TextStyle(fontWeight: FontWeight.w600),),
                         loading: (){
                            return const Expanded(child: LinearProgressIndicator());
                         },
                          data: (data) {
                            return Text(
                              data,
                              style: const TextStyle(fontWeight: FontWeight.w600, color: secondaryColor),
                            );
                          }
                        )
                      ],
                    )),
                    //add control buttons here
                    IconButton(
                      onPressed: () {
                        windowManager.minimize();
                      },
                      icon: const Icon(Icons.minimize, color: secondaryColor,),
                    ),
                    const SizedBox(width: 10,),
                    IconButton(
                      onPressed: () {
                        windowManager.close();
                      },
                      icon: const Icon(Icons.close, color: secondaryColor,),
                    ),                 
                    
    
                  ]),
                ),
              ),
              Expanded(
                child: Row(children: [
                    const SideBar(),
                    Expanded(child: IndexedStack(
                      index: pageIndexProvider,
                      children: const [
                        ClassesPage(),
                        TeachersPage(),
                        TablePage()
                      ],))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}