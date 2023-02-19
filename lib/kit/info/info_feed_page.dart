import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:punk_os/kit/info/info_service.dart';
import 'package:punk_os/kit/info/widget/info_feed_card.dart';

class InfoFeedPage extends StatefulWidget {
  const InfoFeedPage({super.key});

  @override
  State<InfoFeedPage> createState() => _InfoFeedPageState();
}

class _InfoFeedPageState extends State<InfoFeedPage> {
  static const _pageSize = 20;
  List<Map> dataList = [];
  final PagingController<int, Info> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    print('_fetchPage $pageKey');
    final ret = await fetchInfo(pageKey, _pageSize);
    final isLastPage = ret.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(ret);
    } else {
      final nextPageKey = pageKey + ret.length;
      _pagingController.appendPage(ret, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('信息流')),
        body: PagedListView<int, Info>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Info>(
            itemBuilder: (context, item, index) => InfoFeedCard(item),
          ),
        ));
  }
}
