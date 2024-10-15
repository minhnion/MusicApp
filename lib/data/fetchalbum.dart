import 'dart:convert';
import 'package:pro2/data/album.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  var url = "https://thantrieu.com/resources/braniumapis/songs.json";
  var response = await http.get(Uri.parse(url));
  List<Album> albums = [];

  if (response.statusCode == 200) {
    // Sử dụng utf8.decode để giải mã chính xác ký tự tiếng Việt
    var bodyContent = utf8.decode(response.bodyBytes);
    var jsonResponse = json.decode(bodyContent);


    if (jsonResponse is Map<String, dynamic> && jsonResponse['songs'] != null) {
      var songJsonList = jsonResponse['songs'] as List<dynamic>;

      for (var songJson in songJsonList) {
        albums.add(Album.fromJson(songJson));  // Nếu bạn có class Song, thay đổi tên từ Album thành Song
      }
    } else {
      print("Trường 'songs' không tồn tại hoặc có giá trị null.");
    }
  } else {
    print("Yêu cầu HTTP thất bại với mã trạng thái: ${response.statusCode}");
  }

  return albums;
}
