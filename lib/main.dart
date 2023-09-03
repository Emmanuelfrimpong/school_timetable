import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:school_timetable/src/core/utils/colors.dart';
import 'package:school_timetable/src/domain/usercases/hive_database_usecase.dart';
import 'package:school_timetable/src/domain/usercases/startup_usecase.dart';
import 'package:school_timetable/src/presentation/main_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async{
  final HiveDatabaseUseCase hiveDatabaseUseCase = HiveDatabaseUseCase();
  WidgetsFlutterBinding.ensureInitialized();
  await hiveDatabaseUseCase.init();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(950, 600),
    minimumSize: Size(950, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final OnStartUpUseCase onStartUpUseCase = OnStartUpUseCase();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.invertedStylus
        },
      ),
      title: 'School Timetable Maker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        indicatorColor: primaryColor,
        iconTheme: const IconThemeData(color: primaryColor),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        canvasColor: primaryColor,
      ),
      builder: FlutterSmartDialog.init(),
      home: FutureBuilder(
          future: onStartUpUseCase.init(ref),
          builder: (context, snapshot) {
            return const MainPage();
          }),
    );
  }
}

