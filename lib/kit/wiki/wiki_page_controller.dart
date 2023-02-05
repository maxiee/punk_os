import 'package:flutter/material.dart';
import 'package:punk_os/kit/block/block_model.dart';
import 'package:punk_os/kit/block/block_service.dart';
import 'package:punk_os/kit/wiki/wiki_model.dart';
import 'package:punk_os/kit/wiki/wiki_service.dart';

class WikiPageController extends ChangeNotifier {
  late Wiki wiki;

  List<Block> blocks = [];
  int currentEdit = -1;

  setWiki(Wiki wiki) {
    this.wiki = wiki;
    List<String> blockUuids = wiki.getBlockList();
    if (blockUuids.isEmpty) {
      initWikiBlock();
      currentEdit = 0;
    } else {
      parseWikiBlocks(blockUuids);
      currentEdit = blocks.length - 1;
    }
    notifyListeners();
  }

  initWikiBlock() {
    Block b = saveBlock(Block(name: "", content: ""));
    blocks.add(b);

    updateWikiBlocks();

    saveWiki(wiki);
  }

  updateWikiBlocks() {
    wiki.setBlockList(blocks.map((e) => e.uuid!).toList());
  }

  parseWikiBlocks(List<String> blockUuids) {
    for (String blockUuid in blockUuids) {
      final b = getBlockById(blockUuid);
      assert(b != null);
      blocks.add(b!);
    }
  }

  onUpdate(int index, String newContent) {
    blocks[index].content = newContent;
  }

  onSave(Block block) {
    saveBlock(block);
    currentEdit = -1;
    notifyListeners();
  }

  onSaveAndInsertAbrove(int index, Block block) {}

  onSaveAndInsertBelow(int index, Block block) {}
}
