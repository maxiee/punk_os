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
    assert(wiki.uuid != null);

    debugPrint('setWiki');
    debugPrint('currentEdit = $currentEdit');
    debugPrint('blocksLength = ${blocks.length}');

    notifyListeners();
  }

  initWikiBlock() {
    Block b = saveBlock(Block(name: "", content: ""));
    blocks.add(b);

    updateWikiBlocks();
    wiki = saveWiki(wiki);
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

  onSaveAndInsertAbrove(int index, Block block) {
    saveBlock(block);
    debugPrint('index = $index');
    debugPrint('blocksLength = ${blocks.length}');
    Block newBlock = saveBlock(Block(name: "", content: ""));
    blocks.insert(index, newBlock);

    updateWikiBlocks();
    wiki = saveWiki(wiki);

    notifyListeners();
  }

  onSaveAndInsertBelow(int index, Block block) {
    saveBlock(block);
    debugPrint('index = $index');
    debugPrint('blocksLength = ${blocks.length}');
    Block newBlock = saveBlock(Block(name: "", content: ""));
    if (index >= blocks.length - 1) {
      blocks.add(newBlock);
    } else {
      blocks.insert(index + 1, newBlock);
    }
    currentEdit++;

    updateWikiBlocks();
    wiki = saveWiki(wiki);

    notifyListeners();
  }
}
