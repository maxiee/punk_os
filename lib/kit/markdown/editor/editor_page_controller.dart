import 'package:flutter/material.dart';

class EditorPageController extends ChangeNotifier {
  List<String> blocks = [];
  int currentEdit = -1;

  onUpdate(int index, String newContent) {
    blocks[index] = newContent;
  }

  onSubmit(int index) {
    if (index == blocks.length - 1) {
      blocks.add("");
    } else {
      blocks.insert(index, "");
    }
    currentEdit = index + 1;
    notifyListeners();
  }
}
