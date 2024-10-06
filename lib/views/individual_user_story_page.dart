import 'package:flutter/material.dart';
import 'package:inditab_task_flutter/models/user_modal.dart';
import 'package:inditab_task_flutter/views/story_view_page.dart';

// IndividualUserStoryPage displays a paginated view of a user's stories.
class IndividualUserStoryPage extends StatefulWidget {
  final List<Data> user; // List of stories for the user
  final int initialIndex; // Index of the story to show first
  const IndividualUserStoryPage(
      {required this.initialIndex, required this.user, super.key});

  @override
  State<IndividualUserStoryPage> createState() =>
      _IndividualUserStoryPageState();
}

class _IndividualUserStoryPageState extends State<IndividualUserStoryPage> {
  late PageController controller = PageController();
  @override
  void initState() {
    super.initState();
    
    // Initialize PageController with the specified initial story index
    controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller, // Assign the controller to the PageView
      children: widget.user // Create a page for each story
          .map(
            (data) => StoryViewPage( // For each story, create a StoryViewPage
            user: data,
            pageController: controller,
            ),
          )
          .toList(), // Convert the iterable to a list
    );
  }
}
