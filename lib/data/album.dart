class Album {
  String? id;
  String? title;
  String? album;
  String? artist;
  String? source;
  String? image;
  int? duration;
  String? favorite;
  int? counter;
  int? replay;

  Album(
      {this.id,
        this.title,
        this.album,
        this.artist,
        this.source,
        this.image,
        this.duration,
        this.favorite,
        this.counter,
        this.replay});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    album = json['album'];
    artist = json['artist'];
    source = json['source'];
    image = json['image'];
    duration = json['duration'];
    favorite = json['favorite'];
    counter = json['counter'];
    replay = json['replay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['album'] = this.album;
    data['artist'] = this.artist;
    data['source'] = this.source;
    data['image'] = this.image;
    data['duration'] = this.duration;
    data['favorite'] = this.favorite;
    data['counter'] = this.counter;
    data['replay'] = this.replay;
    return data;
  }
}
