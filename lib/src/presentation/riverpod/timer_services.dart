//get stream of time every second
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final currentTimeStream = StreamProvider.autoDispose<String>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) {
    return DateFormat('EEEE, MMM d, yyyy - HH:mm:ss a')
              .format(DateTime.now().toUtc());
  });
});