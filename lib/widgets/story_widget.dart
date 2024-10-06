import 'dart:math';
import 'package:flutter/material.dart';


// Story widget displays a user's story with circular arcs and a profile picture.
class Story extends StatelessWidget {
  final int numberOfarc; // Number of arcs to display
  final double spacing; // Space between arcs
  final double radius; // Radius of the circular avatar
  final double padding; // Padding for the avatar
  final String centerImageUrl; // URL for the profile image
  final double strokeWidth; // Width of the arcs
  final Color arcColor; // Color of the arcs
  final String userName; // User's name displayed below the avatar

  const Story(
      {required this.numberOfarc,
      this.spacing = 10.0,
      this.radius = 50,
      this.padding = 5,
      required this.centerImageUrl,
      this.strokeWidth = 4,
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

            // Create a circular area for the arcs
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

            // Circular avatar displaying the user's profile picture
            CircleAvatar(
              radius: radius - padding,
              backgroundImage: NetworkImage(centerImageUrl),
            ),
          ],
        ),

        // Display the user's name below the avatar
        Text(userName)
      ],
    );
  }
}

// Custom painter class for drawing arcs
class Arc extends CustomPainter {
  final int numberOfArc; // Number of arcs to draw
  final double spacing; // Space between arcs
  final double strokeWidth; // Width of the arc strokes
  final Color arcColor; // Color of the arcs
  Arc(
      {required this.numberOfArc,
      required this.spacing,
      required this.strokeWidth,
      required this.arcColor});

  // Converts degrees to radians
  double doubleToAngle(double angle) => angle * pi / 180.0;

  // Method to draw arcs on the canvas
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
      // Draw each arc based on its position
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          doubleToAngle((start + ((angle + spacing) * i))), // Calculate starting angle
          doubleToAngle(angle), // Arc angle
          false,
          arcPaint); // Draw the arc
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Center of the canvas
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    
    // Radius of the circular area
    final double radius = size.width / 2.0;

    // Determine the angle for arcs; if only one arc, make it a full circle
    double angle = numberOfArc == 1 ? 360.0 : (360.0 / numberOfArc - spacing);
    var startingAngle = 270.0; // Start angle for drawing arcs

    // Create a Paint object for drawing arcs
    Paint arcPaint = Paint()
      ..strokeCap = StrokeCap.round // Round ends for strokes
      ..strokeWidth = strokeWidth // Set stroke width
      ..style = PaintingStyle.stroke // Stroke style for arcs
      ..color = arcColor; // Set arc color

    // Draw arcs using the defined properties
    drawArcWithRadius(canvas, center, radius, angle, arcPaint, startingAngle,
        spacing, numberOfArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
