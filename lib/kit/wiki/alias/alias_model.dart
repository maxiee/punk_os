/// WIKI 别名
class WikiAlias {
  WikiAlias({required this.name, required this.wikiuuid, this.uuid});

  String? uuid;
  String name;
  String wikiuuid;

  Map<String, dynamic> toMap() {
    return {'uuid': uuid, 'name': name, 'wikiuuid': wikiuuid};
  }

  static WikiAlias fromMap(Map<String, dynamic> map) {
    return WikiAlias(
        name: map['name'], wikiuuid: map['wikiuuid'], uuid: map['uuid']);
  }
}
