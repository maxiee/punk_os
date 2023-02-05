/// 内容块
class Block {
  Block({required this.name, required this.content, this.uuid});

  String? uuid;
  String name;
  String content;

  Map<String, dynamic> toMap() {
    return {'uuid': uuid, 'name': name, 'content': content};
  }

  static Block fromMap(Map<String, dynamic> map) {
    return Block(uuid: map['uuid'], name: map['name'], content: map['content']);
  }
}
