import 'package:flutter/material.dart';
import 'package:mediation_app/assets/widgets/track_container.dart';
import 'package:mediation_app/hitmotorAPI/hitmotor_api.dart';
import 'package:mediation_app/hitmotorAPI/objects/track.dart';

class TracksScreen extends StatelessWidget {
  final String href;
  final Image albumImage;
  final String albumName;
  const TracksScreen({super.key, required this.href, required this.albumImage, required this.albumName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 190, 190),
        title: Text(albumName),
      ),
      backgroundColor: const Color(0xffdfdfdf),
      body: _buildStreamBuilder(href)
    );
  }

  _buildStreamBuilder(String href) {
    return StreamBuilder(
      stream: getTracksFromAlbum(href).asStream(),
      builder: (context, snapshot) {
        // tracks
        List<Widget> children = [];

        if (snapshot.hasError) {
          return const Center(
            child: Text('No internet connection...'),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Connecting to hitmotor...')
                  ]
                )
              );
            case ConnectionState.waiting:
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Collecting tracks...')
                  ]
                )
              );
            case ConnectionState.active:
              return const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Preparing tracks...')
                  ]
                )
              );
            case ConnectionState.done:
              children.add(
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
              );
              children.addAll(snapshot.data!.map((Track track) =>
                TrackContainer(
                  name: track.name,
                  author: track.author,
                  trackRef: track.trackRef,
                  time: track.time,
                  songUrl: track.trackRef,
                  albumImage: albumImage,
                )
              ).toList());
            return ListView(
              children: children
            );
          }
        }
      }
    );
  }
}