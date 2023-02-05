/// Wiki 页面
class Wiki {
  Wiki({required this.name, required this.blockList, this.uuid});

  String? uuid;
  String name;
  String blockList;

  List<String> getBlockList() {
    if (blockList.isEmpty) return [];
    return blockList.split(',');
  }

  void setBlockList(List<String> list) {
    blockList = list.join(',');
  }

  Map<String, dynamic> toMap() {
    return {'uuid': uuid, 'name': name, 'content': blockList};
  }

  static Wiki fromMap(Map<String, dynamic> map) {
    return Wiki(
        uuid: map['uuid'], name: map['name'], blockList: map['content']);
  }
}
