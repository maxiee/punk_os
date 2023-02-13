import 'package:get_it/get_it.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/wiki/link/link_model.dart';
import 'package:ray_db/ray_db.dart';

const String kCollectionNameWikiLink = 'wiki_link';

List<WikiLink> getWikiChildren(String wikiUUID) {
  return GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiLink)
      .where()
      .eq('fromUUID', wikiUUID)
      .findAll()
      .map((e) => WikiLink.fromMap(e))
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

void deleteWikiLink(WikiLink l) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameWikiLink)
      .delete(l.uuid!);
  GetIt.I.get<EventBus>().dispatch(kEventRefresh);
}
