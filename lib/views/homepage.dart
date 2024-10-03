import 'package:flutter/material.dart';
import 'package:inditab_task_flutter/models/user_modal.dart';
import 'package:inditab_task_flutter/services/api_services.dart';
import 'package:inditab_task_flutter/views/individual_user_story_page.dart';
import 'package:inditab_task_flutter/views/story_view_page.dart';
import 'package:inditab_task_flutter/widgets/story.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
              SizedBox(
                height: 140,
                child: FutureBuilder<Users>(
                  future: ApiServices.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballClipRotateMultiple,
                          colors: [Colors.blue],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('You are currently offline'),
                      );
                    } else if (snapshot.hasData) {
                      final userData = snapshot.data!.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          IndividualUserStoryPage(
                                            user: snapshot.data!.data!,
                                            initialIndex: index,
                                          )
                                      /*StoryViewPage(
                                      user: userData[index],
                                      //userProfile: snapshot.data!.data,
                                      //initialUserIndex: index,
                                    ),*/
                                      ),
                                );
                              },
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
                      return const Center(
                        child: Text('No data found.'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
