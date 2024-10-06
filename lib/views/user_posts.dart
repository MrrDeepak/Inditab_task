import 'package:flutter/material.dart';
import 'package:inditab_task_flutter/models/post_images.dart';
import 'package:inditab_task_flutter/services/api_services.dart';
import 'package:loading_indicator/loading_indicator.dart';

// UserPosts displays a list of posts made by users.
class UserPosts extends StatelessWidget {
  const UserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the list of image links from the model
    final List<String> postImageLinks = ImageModel.getImageLinks();
    return Expanded(
      child: FutureBuilder(
        future: ApiServices.getUserData(), // Fetch user data asynchronously
        builder: (context, snapshot) {
          // Handle different states of the future
          if (snapshot.connectionState == ConnectionState.waiting) {
            
            // Show a loading indicator while waiting for data
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
            // Display an error message if the data fetch fails
            return const Center(
              child: Text('Error fetching posts'),
            );
          } else if (snapshot.hasData) {
            // When data is available, display it in a ListView
            return ListView.builder(
              itemCount: snapshot.data!.data!.length, // Number of user posts
              itemBuilder: (context, index) {
                final userData = snapshot.data!.data![index]; // Get user data for current index
                
                // POst display in card
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                userData.profilePicture.toString(),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData.userName.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('New York'),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.more_horiz),
                          ],
                        ),
                      ),
                      // Image
                      Image.network(
                        postImageLinks[index], // Replace with your image URL
                        height: 300.0,
                        fit: BoxFit.cover,
                      ),
                      // Actions
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(width: 16.0),
                            Icon(Icons.chat_bubble_outline),
                            SizedBox(width: 16.0),
                            Icon(Icons.send),
                            Spacer(),
                            Icon(Icons.bookmark_border),
                          ],
                        ),
                      ),
                      // Likes
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '12,853 likes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Caption
                      const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                              'Beautiful nature with mountains, waterfall beaches and a shiny day.')),
                      // Hashtags
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '#social #templates #beautiful #funny #dailypost',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No posts found.'),
            );
          }
        },
      ),
    );
  }
}
