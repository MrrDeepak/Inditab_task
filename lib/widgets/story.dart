import 'dart:math';
import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  final int numberOfarc;
  final double spacing;
  final double radius;
  final double padding;
  final String centerImageUrl;
  final double strokeWidth;
  final Color seenColor;
  final Color arcColor;
  final String userName;

  const Story(
      {required this.numberOfarc,
      this.spacing = 10.0,
      this.radius = 50,
      this.padding = 5,
      required this.centerImageUrl,
      this.strokeWidth = 4,
      this.seenColor = Colors.grey,
      this.arcColor = Colors.blue,
      this.userName = '',
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: radius * 2,
              height: radius * 2,
              child: CustomPaint(
                painter: Arc(
                  numberOfArc: numberOfarc,
                  spacing: spacing,
                  strokeWidth: strokeWidth,
                  arcColor: arcColor,
                ),
              ),
            ),
            CircleAvatar(
              radius: radius - padding,
              backgroundImage: NetworkImage(centerImageUrl),
            ),
          ],
        ),
        Text(userName)
      ],
    );
  }
}

class Arc extends CustomPainter {
  final int numberOfArc;
  final double spacing;
  final double strokeWidth;
  final Color arcColor;
  Arc(
      {required this.numberOfArc,
      required this.spacing,
      required this.strokeWidth,
      required this.arcColor});

  double doubleToAngle(double angle) => angle * pi / 180.0;

  void drawArcWithRadius(
    Canvas canvas,
    Offset center,
    double radius,
    double angle,
    Paint arcPaint,
    double start,
    double spacing,
    int number,
  ) {
    for (var i = 0; i < number; i++) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          doubleToAngle((start + ((angle + spacing) * i))),
          doubleToAngle(angle),
          false,
          arcPaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = size.width / 2.0;
    double angle = numberOfArc == 1 ? 360.0 : (360.0 / numberOfArc - spacing);
    var startingAngle = 270.0;

    Paint arcPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = arcColor;

    drawArcWithRadius(canvas, center, radius, angle, arcPaint, startingAngle,
        spacing, numberOfArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
