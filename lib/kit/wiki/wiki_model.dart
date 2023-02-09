/// Wiki 页面
class Wiki {
  Wiki(
      {required this.name,
      required this.content,
      required this.contentStr,
      this.uuid,
      this.mark});

  String? uuid;
  String name;
  String content;
  String contentStr;
  int? mark;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'content': content,
      'content_str': contentStr,
      'mark': mark
    };
  }

  static Wiki fromMap(Map<String, dynamic> map) {
    return Wiki(
        uuid: map['uuid'],
        name: map['name'],
        contentStr: map['content_str'],
        content: map['content'],
        mark: map['mark']);
  }
}
