import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mediation_app/hitmotorAPI/objects/music_player_controller_singleton.dart';
import 'package:mediation_app/screens/music_player.dart';

class TrackContainerForHistory extends StatelessWidget {
  final String author;
  final String name;
  final String time;
  final String trackRef;
  final String songUrl;
  final Image? albumImage;

  const TrackContainerForHistory({super.key, required this.name, required this.author, required this.trackRef, required this.time, required this.songUrl, this.albumImage});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 190, 190, 190),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
      ),
      child: MaterialButton (
        onPressed: () {
          MusicPlayerControllerSingleton().player.play(UrlSource(trackRef));
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicPlayer(
                albumImage: albumImage ?? Image.asset('images/no_image.png'),
                songUrl: trackRef
              )
            )
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      author,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}