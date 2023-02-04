/// 任务
class Task {
  Task(
      {required this.name,
      required this.finish,
      required this.created,
      this.uuid,
      this.deadline});

  static const int kFinish = 1;
  static const int kUnfinish = 0;

  String? uuid;
  String name;
  int finish; // 0 unfinish, 1 finish
  DateTime created;
  DateTime? deadline;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'finish': finish,
      'created': created.millisecondsSinceEpoch,
      if (deadline != null) 'deadline': deadline!.millisecondsSinceEpoch
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
        uuid: map['uuid'],
        name: map['name'],
        finish: map['finish'],
        created: DateTime.fromMillisecondsSinceEpoch(map['created']),
        deadline: map['deadline'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['deadline'])
            : null);
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    sb.write(finish == kFinish ? "[√]" : "[ ]");
    sb.write(' ');
    sb.write(name);
    return sb.toString();
  }
}
