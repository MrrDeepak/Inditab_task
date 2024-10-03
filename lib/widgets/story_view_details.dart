import 'package:flutter/material.dart';

class StoryViewDetails extends StatelessWidget {
  final String title;
  final String description;
  const StoryViewDetails({required this.title,required this.description,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 82.0),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Text(description,
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
