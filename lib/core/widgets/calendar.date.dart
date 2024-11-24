import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekRowCalendar extends StatelessWidget {
  final DateTime startDate;

  const WeekRowCalendar({Key? key, required this.startDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            // Generate 7 days of the week
            DateTime currentDay = startDate.add(Duration(days: index));
            String dayNumber = DateFormat.d().format(currentDay); // Day number
            String weekday = DateFormat.EEEE()
                .format(currentDay)[0]; // First letter of the day

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Stack to overlay the day number inside the CircularProgressIndicator
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Progress Indicator wrapping the day number
                      const SizedBox(
                        height: 30, // Height of the circular progress indicator
                        width: 30, // Width of the circular progress indicator
                        child: CircularProgressIndicator(
                          strokeAlign: 1,
                          value:
                              0.4, // Set the progress value (from 0.0 to 1.0)
                          backgroundColor: Colors.black12, // Background color
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xffE6198F)), // Progress color
                          strokeWidth:
                              3, // The thickness of the circular progress
                        ),
                      ),
                      // Day number centered inside the circular progress indicator
                      Text(
                        dayNumber,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff732652),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  // Weekday First Letter Text below the CircularProgressIndicator
                  Text(
                    weekday,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff732652),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
