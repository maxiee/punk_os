/// WIKI 别名
class WikiAlias {
  WikiAlias({required this.name, this.uuid});

  String? uuid;
  String name;

  Map<String, dynamic> toMap() {
    return {'uuid': uuid, 'name': name};
  }

  static WikiAlias fromMap(Map<String, dynamic> map) {
    return WikiAlias(name: map['name'], uuid: map['uuid']);
  }
}
