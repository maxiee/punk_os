import 'package:get_it/get_it.dart';
import 'package:punk_os/kit/db/ray_info_db.dart';

const String kCollectionNameInfo = 'info';

List<Map> getInfoPage(int page, int pageSize) {
  return GetIt.I
      .get<RayInfoDB>()
      .db
      .collection(kCollectionNameInfo)
      .where()
      .limit(pageSize)
      .skip(page * pageSize)
      .findAll();
}
