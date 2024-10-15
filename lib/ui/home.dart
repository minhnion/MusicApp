import 'package:flutter/material.dart';
import 'package:pro2/data/album.dart';
import 'package:pro2/data/fetchalbum.dart';

import 'detailsong.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  @override
  List<Album> _albums = [];
  List<Album> _albumall = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAlbum().then((value) {
      setState(() {
        _albums.addAll(value);
        _albumall.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Good morning',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  width: 120,
                ),
                Icon(
                  Icons.notification_add_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white30,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                      child: const Text(
                        'Music',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                  const SizedBox(
                    width: 9,
                  ),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white30,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                      child: const Text(
                        'Podcasts & Shows',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: const TextStyle(color: Colors.cyanAccent),
                onChanged: (text) {
                  text = text.toLowerCase();
                  setState(() {
                    // Dùng danh sách gốc để lọc
                    _albums = _albumall.where((album) {
                      var title = album.title?.toLowerCase() ?? '';
                      return title.contains(text);
                    }).toList();
                  });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Số cột là 2
                  crossAxisSpacing: 10.0, // Khoảng cách giữa các cột
                  mainAxisSpacing: 10.0, // Khoảng cách giữa các hàng
                  childAspectRatio:
                      3 / 2, // Tỷ lệ chiều rộng/chiều cao của các ô
                ),
                itemCount: _albums.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // Điều chỉnh padding nếu cần
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hiển thị ảnh từ URL
                              Expanded(
                                child: Image.network(
                                  _albums[index].image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 100,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons
                                        .error); // Hiển thị biểu tượng lỗi nếu không tải được ảnh
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              album: _albums[index],
                              albumList: _albums, // Truyền danh sách album
                              currentIndex: index, // Truyền chỉ mục hiện tại
                            ), // Truyền dữ liệu album
                          ),
                        );
                      });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.home_filled,
                          color: Colors.white,
                          size: 30,
                        )),
                    //SizedBox(height: 2,),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        )),
                    //SizedBox(height: 2,),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.my_library_music_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
                    //SizedBox(height: 2,),
                    Text(
                      'Your library',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
