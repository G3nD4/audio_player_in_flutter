import 'package:audioplayers/audioplayers.dart';
import 'package:mediation_app/hitmotorAPI/objects/track.dart';
import 'package:mediation_app/hitmotorAPI/objects/tracks_playlist.dart';

class MusicPlayerControllerSingleton {
  late AudioPlayer player;
  String? urlScr;
  late TracksPlaylist playlist;
  late Track chosenTrack;

  static final MusicPlayerControllerSingleton _musicPlayerComtrollerSingleton = MusicPlayerControllerSingleton._internal();
  factory MusicPlayerControllerSingleton() {
    return _musicPlayerComtrollerSingleton;
  }
  
  MusicPlayerControllerSingleton._internal() {
    player = AudioPlayer();
    playlist = TracksPlaylist([], null);
  }

  setPlaylist(List<Track> newPlaylist) {
    playlist.playlist.clear();
    playlist.playlist.addAll(newPlaylist);
  }

  getTrackList() async {
    return playlist.playlist;
  }

  play(String newUrlScr) async {
    if (urlScr == null) {
      urlScr = newUrlScr;
      await player.play(UrlSource(newUrlScr));
      await setCurrentlyPlayingTrackByRef(newUrlScr);
    } else {
      if (urlScr != newUrlScr) {
        urlScr = newUrlScr;
        await player.stop();
        await player.play(UrlSource(newUrlScr));
        await setCurrentlyPlayingTrackByRef(newUrlScr);
        /* player.onPlayerStateChanged.listen((event) {
          switch (event) {
            case PlayerState.paused:
              player.play(UrlSource(newUrlScr));
              break;
            case PlayerState.completed:
              player.play(UrlSource(newUrlScr));
              break;
            default:
              break;
          }
        }); */
      }
      else {
        await player.resume();
      }
    }
  }

  setCurrentlyPlayingTrackByRef(String ref) async {
    await _getTrackByRef(ref).then(
      (value) {
        if (value != null) {
          playlist.currentlyPlaying = value;
        }
      }
    );
  }

  setCurrentlyPlayingTrackAsNull() {
    playlist.currentlyPlaying = null;
  }

  _getTrackByRef(String ref) {
    for (Track track in playlist.playlist) {
      if (track.trackRef == ref) {
        return track;
      }
    }
    return null;
  }

  pause() async {
    await player.pause();
  }

  stop() async {
    urlScr = null;
    setCurrentlyPlayingTrackAsNull();
    await player.stop();
  }
}