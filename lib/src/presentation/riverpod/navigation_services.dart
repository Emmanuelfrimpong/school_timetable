import 'package:flutter_riverpod/flutter_riverpod.dart';

final sidebarWidthProvider = StateProvider<double>((ref) {
  return 60.0;
});

final mainPageNavigationProvider = StateProvider<int>((ref) {
  return 0;
});