import 'package:flutter/material.dart';
import 'package:tiktok_flutter/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView.builder(
        // itemCount: ,
        controller: PageController(
          initialPage: 0,
          viewportFraction: 1,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // VideoPlayerItem(
              // videoUrl: ,
              // ),
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
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'username',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'caption',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.music_note,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'song name',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(
                          top: size.height / 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
