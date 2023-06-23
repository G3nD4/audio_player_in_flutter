import 'package:flutter/material.dart';
import 'package:mediation_app/assets/widgets/track_container_for_history.dart';
import 'package:mediation_app/hitmotorAPI/objects/music_player_controller_singleton.dart';
import 'package:mediation_app/hitmotorAPI/objects/track.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdfdfdf),
      body: _buildStreamBuilder(),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back To Player')
            ),
          ),
        ],
      ),
    );
  }

  _buildStreamBuilder() {
    return StreamBuilder(
      stream: MusicPlayerControllerSingleton().getTrackList().asStream(),
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
              for (Track track in snapshot.data! as List<Track>) {
                children.add(TrackContainerForHistory(
                  name: track.name,
                  author: track.author,
                  trackRef: track.trackRef,
                  time: track.time,
                  songUrl: track.trackRef,
                ));
              }

            return ListView(
              children: children
            );
          }
        }
      }
    );
  }
}