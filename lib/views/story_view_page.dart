import 'package:flutter/material.dart';
import 'package:inditab_task_flutter/models/user_modal.dart';
import 'package:inditab_task_flutter/widgets/story_view/controller/story_controller.dart';
import 'package:inditab_task_flutter/widgets/story_view/utils.dart';
import 'package:inditab_task_flutter/widgets/story_view/widgets/story_view_widget.dart';
import 'package:inditab_task_flutter/widgets/story_view_caption.dart';

class StoryViewPage extends StatefulWidget {
  final Data user;
  final PageController pageController;
  const StoryViewPage({
    required this.user,
    required this.pageController,
    super.key,
  });

  @override
  State<StoryViewPage> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryViewPage> {
  StoryController storyController = StoryController();

  final List<StoryItem> userStory = [];

  void addStoryItems() {
    for (final story in widget.user.stories!) {
      switch (story.mediaType) {
        case "video":
          userStory.add(
            StoryItem.pageVideo(
                duration: const Duration(seconds: 10),
                url: story.mediaUrl.toString(),
                controller: storyController,
                imageFit: BoxFit.contain,
                caption: StoryViewDetails(
                    title: story.text.toString(),
                    description: story.textDescription.toString())),
          );
          break;
        case "image":
          userStory.add(
            StoryItem.pageImage(
              url: story.mediaUrl.toString(),
              controller: storyController,
              imageFit: BoxFit.contain,
              caption: StoryViewDetails(
                title: story.text.toString(),
                description: story.textDescription.toString(),
              ),
            ),
          );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    addStoryItems();
    storyController = StoryController();
  }

  @override
  void dispose() {
    super.dispose();
    storyController.dispose();
  }

  // void handleCompleted() {
  //   widget.pageController.nextPage(
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeIn,
  //   );
  //   final currentIndex = users.
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StoryView(
          storyItems: userStory,
          controller: storyController,
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
          onComplete: () => Navigator.pop(context),
          repeat: false,
          inline: true,
        ),
        // User Profile view on Status
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SafeArea(
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        NetworkImage(widget.user.profilePicture.toString()),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      widget.user.userName.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
