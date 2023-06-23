import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:mediation_app/hitmotorAPI/objects/music_player_controller_singleton.dart';
import 'package:mediation_app/screens/history_screen.dart';



/* class MusicPlayer extends StatefulWidget {
  final AudioPlayer player;
  final Image albumImage;
  const MusicPlayer({super.key, required this.player, required this.albumImage});

  @override
  State<StatefulWidget> createState() {
    return _MusicPlayerState();
  }
}

 */
class MusicPlayer extends StatelessWidget{//<MusicPlayer> {
  final String songUrl;
  final Image albumImage;
  const MusicPlayer({super.key, required this.albumImage, required this.songUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdfdfdf),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 190, 190),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: const Color(0xff212435),
                iconSize: 24,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 190, 190, 190),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen()
                    )
                  );
                },
                color: const Color(0xff212435),
                iconSize: 24,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: const Color(0x00a8a8a8),
          shape: BoxShape.rectangle,
          border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: const Color(0x1f000000),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image(
                  image: albumImage.image,
                  height: 100,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.stop),
                      onPressed: () {
                        MusicPlayerControllerSingleton().pause();
                      },
                      color: const Color(0xff212435),
                      iconSize: 24,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        MusicPlayerControllerSingleton().play(songUrl);
                      },
                      color: const Color(0xff212435),
                      iconSize: 24,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        MusicPlayerControllerSingleton().stop();
                      },
                      color: const Color(0xff212435),
                      iconSize: 24,
                    ),
                  ),
                ],
              )
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: const MusicProgressBar(),
            )
          ],
        ),
      ),
    );
  }
}

class MusicProgressBar extends StatefulWidget {
  const MusicProgressBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MusicProgressBarState();
  }

}

class _MusicProgressBarState extends State<MusicProgressBar> {
  int timePassed = 0;
  late String timeTotal;



  getTimeTotal() async {
    await MusicPlayerControllerSingleton().player.getCurrentPosition().then((value) {
      timeTotal = value.toString();
      print(timeTotal);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('')
          ],
        ),
        Slider(
          value: 0,//MusicPlayerControllerSingleton().playlist.currentlyPlaying.time,
          onChanged: (context) {
             getTimeTotal();
          }
        ),
      ],
    );
  }

}