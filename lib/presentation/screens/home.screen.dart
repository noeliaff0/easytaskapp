import 'package:easytaskapp/core/widgets/buttoms.row.dart';
import 'package:easytaskapp/core/widgets/calendar.date.dart';
import 'package:easytaskapp/core/widgets/floating.bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 240),
              painter: TopCurvePainter(),
            ),
            // Add content on top of the curve
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 60, left: 35),
                child: Row(
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1.45,
                        color: Color(0xFF732652),
                      ),
                    ),
                    Spacer(),
                    IconButtomRow()
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(child: WeekRowCalendar(startDate: DateTime.now())),
              const Expanded(
                child: Center(
                  child: Text("No tasks today,\nAdd a new one to get started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -1.45,
                        color: Color(0xff732652),
                      )),
                ),
              ),
            ]),
          ],
        ),
        floatingActionButton: FloatingABottom());
  }
}

class TopCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the filled curve
    final paint = Paint()
      ..color = const Color(0xffFDF2F8) // Background color
      ..style = PaintingStyle.fill;

    // Path for the filled curve
    final path = Path();
    path.lineTo(0, size.height - 30); // Starting point (left bottom)
    path.quadraticBezierTo(
      size.width / 2, // Control point x
      size.height, // Control point y
      size.width, // End point x
      size.height - 30, // End point y
    );
    path.lineTo(size.width, 0); // Top-right corner
    path.close(); // Closes the path

    canvas.drawPath(path, paint);

    // Paint for the dashed curve
    final dashedPaint = Paint()
      ..color = Colors.pink.shade200 // Dash color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Path for the dashed curve
    final dashedPath = Path();
    dashedPath.moveTo(0, size.height - 30); // Starting point
    dashedPath.quadraticBezierTo(
      size.width / 2, // Control point x
      size.height, // Control point y
      size.width, // End point x
      size.height - 30, // End point y
    );

    _drawDashedLine(canvas, dashedPath, dashedPaint);
  }

  // Helper method to draw dashed lines along a path
  void _drawDashedLine(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 6.0;

    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final segment = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint if nothing changes
  }
}
