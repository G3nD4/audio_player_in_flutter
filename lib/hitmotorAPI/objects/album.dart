class Album {
  String album = 'undefined';
  String author = 'undefined';
  String href = 'undefined';
  String imageRef = '';
  Album({required this.album, required this.author, required this.href, required this.imageRef});

  @override
  String toString() {
    return 'album: $album\nauthor: $author\nhref: $href\nimageRef: $imageRef';
  }
}