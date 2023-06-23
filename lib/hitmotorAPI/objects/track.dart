class Track {
  String author = 'undefined';
  String name = 'undefined';
  String time = 'undefined';
  String trackRef = '';
  Track({required this.time, required this.author, required this.name, required this.trackRef});

  @override
  String toString() {
    return 'name: $name\nauthor: $author\ntime: $time\ntrackRef: $trackRef';
  }
}