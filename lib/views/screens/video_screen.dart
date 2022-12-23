import 'package:flutter/material.dart';
import 'package:tiktok_clone_app/constants.dart';
import 'package:tiktok_clone_app/views/widgets/video_player_item.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  buildProfile(String profilePhoto) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
          itemCount: 10,
          controller: PageController(initialPage: 0, viewportFraction: 1.0),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                // VideoPlayerItem(videoUrl: ,),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Username",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  const Text(
                                    "caption",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.music_note,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(
                                        "song name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(top: size.height / 5),
                            child: Column(
                              children: [
                                buildProfile("String url")
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          }),
    );
  }
}
