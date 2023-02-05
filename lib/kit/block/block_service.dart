import 'package:get_it/get_it.dart';
import 'package:punk_os/base/event_bus/event_bus.dart';
import 'package:punk_os/constant.dart';
import 'package:punk_os/kit/block/block_model.dart';
import 'package:ray_db/ray_db.dart';

const String kCollectionNameBlock = 'block';

Block saveBlock(Block b) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameBlock)
      .storeMap(b.toMap());
  GetIt.I.get<EventBus>().dispatch(kEventRefresh);
  return Block.fromMap(ret);
}

Block? getBlockById(String uuid) {
  final ret = GetIt.I
      .get<Database>()
      .collection(kCollectionNameBlock)
      .where()
      .eq('uuid', uuid)
      .findFirst();
  if (ret == null) return null;
  return Block.fromMap(ret);
}
