import 'package:get_it/get_it.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:ray_db/ray_db.dart';

const String kCollectionNameWiki = 'wiki';

Wiki saveWiki(Wiki w) {
  GetIt.I.get<Database>().collection(kCollectionNameWiki).storeMap(w.toMap());
  GetIt.I.get<EventBus>().dispatch(kEventRefresh);
  return w;
}

Wiki? getWikiByName(String name) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameWiki)
      .where()
      .eq('name', name)
      .findFirst();
  if (ret == null) return null;
  return Wiki.fromMap(ret);
}
