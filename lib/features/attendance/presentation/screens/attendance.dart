import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/features/attendance/presentation/providers/attendance_providers.dart';
import 'package:jivodsr/features/attendance/presentation/widgets/today_card.dart';


class AttendanceScreen extends ConsumerWidget{

  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final monthAsync = ref.watch(attendanceMonthProvider);

    return monthAsync.when(
      data: (month){
        final today = month.dayFor(DateTime.now());
        return ListView(
          children: [

            if(today != null) 
              TodayCard(),
            
          ],
        );
      }, error: (error,_) => Center(
        child: Text('Error: $error'),
      ),
      loading: () =>const Center(child: CircularProgressIndicator(),));
  }
}
