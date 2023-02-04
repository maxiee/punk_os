/// 任务
class Task {
  Task({required this.name, required this.finish, required this.created});

  String name;
  bool finish;
  DateTime created;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'finish': finish,
      'created': created.millisecondsSinceEpoch
    };
  }

  Task fromMap(Map<String, dynamic> map) {
    return Task(
        name: map['name'],
        finish: map['finish'],
        created: DateTime.fromMillisecondsSinceEpoch(map['created']));
  }
}
