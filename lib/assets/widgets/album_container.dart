import 'package:flutter/material.dart';
import 'package:mediation_app/hitmotorAPI/hitmotor_api.dart';
import 'package:mediation_app/hitmotorAPI/objects/music_player_controller_singleton.dart';
import 'package:mediation_app/screens/tracks_screen.dart';

class AlbumContainer extends StatelessWidget {
  final String albumName;
  final String albumAuthor;
  final String href;
  final Image albumImage;

  const AlbumContainer({super.key, required this.albumImage, required this.albumName, required this.albumAuthor, required this.href});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 190, 190, 190),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
      ),
      child: MaterialButton (
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TracksScreen(
                href: 'https://rus.hitmotop.com$href',
                albumImage: albumImage,
                albumName: albumName,
              )
            )
          );
          await getTracksFromAlbum('https://rus.hitmotop.com$href')
            .then(
              (value) => MusicPlayerControllerSingleton().setPlaylist(value)
            );
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image(
                  image: albumImage.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  albumName,
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
                  albumAuthor,
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
          ],
        ),
      ),
    );
  }

  toList() {}
}