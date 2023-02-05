/// 内容块
class Block {
  Block({required this.content, this.uuid});

  String? uuid;
  String content;

  Map<String, dynamic> toMap() {
    return {'uuid': uuid, 'content': content};
  }

  static Block fromMap(Map<String, dynamic> map) {
    return Block(uuid: map['uuid'], content: map['content']);
  }
}
