import 'package:get_it/get_it.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/wiki/link/link_model.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';
import 'package:ray_db/ray_db.dart';

const String kCollectionNameWikiLink = 'wiki_link';

List<Wiki> getWikiChildren(String wikiUUID) {
  return GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiLink)
      .where()
      .eq('fromUUID', wikiUUID)
      .findAll()
      .map((e) => WikiLink.fromMap(e))
      .map((e) => getWikiByUUID(e.toUUID)!)
      .toList();
}

WikiLink saveWikiLink(WikiLink l) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiLink)
      .storeMap(l.toMap());
  GetIt.I.get<EventBus>().dispatch(kEventRefresh);
  return WikiLink.fromMap(ret);
}
