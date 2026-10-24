import 'package:flutter/material.dart';

class TodayCard extends StatelessWidget {
  const TodayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Cont(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Friday, 24-Oct-2026',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                       
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         Text(
                          'Present',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                       Text(
                      'Punch In',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '9:41 AM',
                      style: Theme.of(context).textTheme.bodyMedium,
                      ),

                    ]),

                  ],
                ),
                ],),
                const SizedBox(height: 4.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
