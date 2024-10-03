import 'package:flutter/material.dart';
import 'package:inditab_task_flutter/models/user_modal.dart';
import 'package:inditab_task_flutter/views/story_view_page.dart';

class IndividualUserStoryPage extends StatefulWidget {
  final List<Data> user;
  final int initialIndex;
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

    controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: widget.user
          .map(
            (data) => StoryViewPage(user: data,
            pageController: controller,
            ),
          )
          .toList(),
    );
  }
}
