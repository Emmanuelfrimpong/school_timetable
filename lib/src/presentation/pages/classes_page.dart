import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_timetable/src/core/utils/colors.dart';

class ClassesPage extends ConsumerStatefulWidget {
  const ClassesPage({super.key});

  @override
  ConsumerState<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends ConsumerState<ClassesPage> {
  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: primaryColor),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: const Text('Import Class'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: const Text('Download Template'),
              ),
               const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: const Text('Clear All'),
              ),

            ],
          ),
          const Divider( color: primaryColor,thickness: 2,),
          const SizedBox(height: 20),
          
        ],
      )
    );
  }
}