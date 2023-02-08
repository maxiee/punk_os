import 'package:get_it/get_it.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/wiki/alias/alias_model.dart';
import 'package:ray_db/ray_db.dart';

const String kCollectionNameWikiAlias = 'wiki_alias';

WikiAlias saveWikiAlias(WikiAlias w) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiAlias)
      .storeMap(w.toMap());
  GetIt.I.get<EventBus>().dispatch(kEventRefresh);
  return WikiAlias.fromMap(ret);
}

List<WikiAlias> searchWikiAliasByName(String name) {
  return GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiAlias)
      .where()
      .like('name', name)
      .findAll()
      .map((e) => WikiAlias.fromMap(e))
      .toList();
}

WikiAlias? getWikiAliasByName(String name) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiAlias)
      .where()
      .eq('name', name)
      .findFirst();
  if (ret == null) return null;
  return WikiAlias.fromMap(ret);
}

WikiAlias? getWikiAliasByUUID(String uuid) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiAlias)
      .where()
      .eq('uuid', uuid)
      .findFirst();
  if (ret == null) return null;
  return WikiAlias.fromMap(ret);
}
