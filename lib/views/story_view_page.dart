import 'package:flutter/material.dart';
import 'package:inditab_task_flutter/models/user_modal.dart';
import 'package:inditab_task_flutter/widgets/story_view/controller/story_controller.dart';
import 'package:inditab_task_flutter/widgets/story_view/utils.dart';
import 'package:inditab_task_flutter/widgets/story_view/widgets/story_view_widget.dart';
import 'package:inditab_task_flutter/widgets/story_view_caption.dart';

// StoryViewPage displays a single user's stories in a swipeable format.
class StoryViewPage extends StatefulWidget {
  final Data user; // User data containing the stories
  final PageController pageController; // Controller for page navigation
  const StoryViewPage({
    required this.user,
    required this.pageController,
    super.key,
  });

  @override
  State<StoryViewPage> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryViewPage> {
  // Controller for managing story playback
  StoryController storyController = StoryController(); 

  final List<StoryItem> userStory = [];  // List to hold the user's stories


  // Method to populate userStory list based on user's stories
  void addStoryItems() {
    for (final story in widget.user.stories!) {
      switch (story.mediaType) {
        case "video":
          userStory.add(
            StoryItem.pageVideo(
                duration: const Duration(seconds: 15),
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // StoryView widget to display the user's stories
        StoryView(
          storyItems: userStory, // Pass the list of stories
          controller: storyController, // Pass the story controller
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context); // Close the view on vertical down swipe
            }
          },
          onComplete: () => Navigator.pop(context), // Close the view when stories complete
          repeat: false,
          inline: true,
        ),
        // User Profile view on top of the stories
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SafeArea(
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User's profile picture
                  CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        NetworkImage(widget.user.profilePicture.toString()),
                  ),

                  // User's name displayed beside the profile picture
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
