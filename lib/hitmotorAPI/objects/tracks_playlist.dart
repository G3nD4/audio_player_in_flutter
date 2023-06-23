import 'package:mediation_app/hitmotorAPI/objects/track.dart';

class TracksPlaylist {
  List<Track> playlist;
  Track? currentlyPlaying;
  TracksPlaylist(this.playlist, this.currentlyPlaying);
}