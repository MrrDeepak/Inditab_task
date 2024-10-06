import 'package:flutter/material.dart';
import 'package:inditab_task_flutter/models/user_modal.dart';
import 'package:inditab_task_flutter/services/api_services.dart';
import 'package:inditab_task_flutter/views/individual_user_story_page.dart';
import 'package:inditab_task_flutter/views/user_posts.dart';
import 'package:inditab_task_flutter/widgets/story_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';

// HomePage widget that serves as the main screen for the social app.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Social',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // A fixed-height section for user stories.
            SizedBox(
              height: 140,
              child: FutureBuilder<Users>(
                future: ApiServices
                    .getUserData(), //// Fetching user data asynchronously
                builder: (context, snapshot) {
                  //// Handling different states of the Future.
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for data, show a loading indicator
                    return const Center(
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballClipRotateMultiple,
                          colors: [Colors.blue],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // If an error occurs, show an error message
                    return const Center(
                      child: Text('You are currently offline'),
                    );
                  } else if (snapshot.hasData) {
                    // If data is successfully fetched
                    final userData = snapshot.data!.data;
                    return ListView.builder(
                      shrinkWrap:
                          true, // Prevents ListView from expanding indefinitely
                      scrollDirection:
                          Axis.horizontal, // Horizontal scrolling for stories
                      itemCount: snapshot.data!.data!.length, // Number of users
                      itemBuilder: (context, index) {
                        // Building each story item
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: GestureDetector(
                            // Navigate to IndividualUserStoryPage on tap.
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndividualUserStoryPage(
                                    user: snapshot.data!.data!,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            // Custom widget to display user story
                            child: Story(
                              userName: userData![index].userName.toString(),
                              centerImageUrl:
                                  userData[index].profilePicture.toString(),
                              numberOfarc: userData[index].stories!.length,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // If no data found, show a message
                    return const Center(
                      child: Text('No data found.'),
                    );
                  }
                },
              ),
            ),
            // UserPosts widget displaying posts from users
            const UserPosts()
          ],
        ),
      ),
    );
  }
}
