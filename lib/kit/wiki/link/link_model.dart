/// WIKI 双链
class WikiLink {
  WikiLink({required this.fromUUID, required this.toUUID, this.uuid});

  String? uuid;
  String fromUUID;
  String toUUID;

  Map<String, dynamic> toMap() {
    return {'uuid': uuid, 'fromUUID': fromUUID, 'toUUID': toUUID};
  }

  static WikiLink fromMap(Map<String, dynamic> map) {
    return WikiLink(
        fromUUID: map['fromUUID'], toUUID: map['toUUID'], uuid: map['uuid']);
  }
}
