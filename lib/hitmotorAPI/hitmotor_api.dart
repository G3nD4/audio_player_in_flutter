import 'package:html/parser.dart';
import 'package:mediation_app/hitmotorAPI/objects/album.dart';
import 'package:requests/requests.dart';
import 'package:mediation_app/hitmotorAPI/objects/track.dart';


void main() {
  //getAlbumsFromHitmotor(3);
  //getTracksFromAlbum('https://rus.hitmotop.com/album/763844');
}

Future<List<Album>> getAlbumsFromHitmotor(int multiplier) async {
  int amount = 40 * multiplier;
  late final URL;
  if (amount < 40) {
    URL = 'https://rus.hitmotop.com/albums';
  } else {
    URL = 'https://rus.hitmotop.com/albums/start/$amount';
  }

  // connecting and getting doc
  var resp = await Requests.get(URL);
  var document = parse(resp.body);

  // parsing necessary data (weirdest way)
  final hrefs = [];
  final imageRefs = [];
  for (var elem in document.getElementsByClassName('album-item')) {
    String temp = elem.innerHtml.substring(22, 50);
    for (int i = 0; i < temp.length; ++i) {
      if (temp[i] == '"') {
        temp = temp.substring(0, i);
      }
    }
    hrefs.add(temp);
    temp = elem.getElementsByClassName('album-link')[0].innerHtml.substring(77);
    for (int i = 0; i < temp.length; ++i) {
      if (temp[i] == '\'') {
        temp = 'http:${temp.substring(0, i)}';
      }
    }
    imageRefs.add(temp);
  }

  final songs = document
      .getElementsByClassName('album-title');
  final authors = document
      .getElementsByClassName('album-singer');
  List<Album> albums = [];
  for (int i = 0; i < 40; ++i) {
    albums.add(Album(
      album: songs[i].text.trimLeft().trimRight(),
      author: authors[i].text.trimLeft().trimRight(),
      href: hrefs[i],
      imageRef: imageRefs[i]
    ));
  }

  return albums;
}

Future<List<Track>> getTracksFromAlbum(String URL) async {
  // connecting and getting doc
  var resp = await Requests.get(URL);
  var document = parse(resp.body);

  List<Track> tracks = [];
  final trackNames = document.getElementsByClassName('track__title');
  final trackAuthors = document.getElementsByClassName('track__desc');
  final times = document.getElementsByClassName('track__fulltime');
  final trackRefs = document.getElementsByClassName('track__download-btn');

  for (int i = 0; i < trackNames.length; ++i) {
    if (trackRefs[2 * i].attributes['href'] != null) {
      tracks.add(Track(
      time: times[i].text,
      author: trackAuthors[i].text.trimLeft().trimRight(),
      name: trackNames[i].text.trimLeft().trimRight(),
      trackRef: trackRefs[2 * i].attributes['href']!  // HERE
    ));
    }
  }

  return tracks;
}