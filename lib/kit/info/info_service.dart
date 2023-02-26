import 'dart:convert';
import 'package:http/http.dart' as http;

class Info {
  final String title;
  List<dynamic> titleFC;
  final DateTime updated;
  final String url;
  final String site;
  final String site_img;
  final String description;
  List<dynamic> descriptionFC;
  int like;
  final List<String> images;

  Info(
      {required this.title,
      required this.titleFC,
      required this.updated,
      required this.url,
      required this.site,
      required this.site_img,
      required this.images,
      required this.description,
      required this.descriptionFC,
      required this.like});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'],
      titleFC: json['title_fc'],
      updated: DateTime.parse(json['updated']),
      url: json['url'],
      site: json['site'],
      site_img: json['site_img'] ?? '',
      images: (jsonDecode(json['images'] ?? "[]") as List<dynamic>).cast() ,
      description: json['description'],
      descriptionFC: json['description_fc'],
      like: json['like'],
    );
  }
}

Future<List<Info>> fetchInfo(int skip, int limit) async {
  Utf8Decoder decode = const Utf8Decoder();
  final response = await http.get(
      Uri.parse('http://127.0.0.1:1127/info/list?skip=$skip&limit=$limit'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(decode.convert(response.bodyBytes));
    return data.map((json) => Info.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future addWord(String word) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:1127/add_word?word=$word'));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future likeWord(String word) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:1127/like_word?word=$word'));
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<List> cut(String words) async {
  Utf8Decoder decode = const Utf8Decoder();
  final response =
      await http.get(Uri.parse('http://127.0.0.1:1127/cut?words=$words'));
  if (response.statusCode == 200) {
    return json.decode(decode.convert(response.bodyBytes));
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<bool> isDBBusy() async {
  Utf8Decoder decode = const Utf8Decoder();
  final response =
      await http.get(Uri.parse('http://127.0.0.1:1127/is_db_busy'));
  if (response.statusCode == 200) {
    String ret = decode.convert(response.bodyBytes);
    print('isDBBusy ret = $ret');
    return ret == 'true';
  } else {
    throw Exception('Failed to fetch data');
  }
}
