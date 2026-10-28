import 'package:flutter/material.dart';
import 'package:jivodsr/core/theme/app_colors.dart';

class TodayCard extends StatelessWidget {

  const TodayCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [

            Row(
              children: [
                Expanded(
                  child: Text(
                    'Friday, 24-Oct-2026',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                Text('Present', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),

            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                                           
  
                          children: [
                            Text(
                              'Punch In',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        
                            Text(
                              '9:41 AM',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const VerticalDivider(width: 1),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Punch Out',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        
                            Text(
                              '9:41 AM',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const VerticalDivider(width: 1),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text(
                              'Worked',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        
                            Text(
                              '1h 31m',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
    
  }
}
