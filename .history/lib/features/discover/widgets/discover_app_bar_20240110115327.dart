import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

class DiscoverAppBar extends StatelessWidget {
  const DiscoverAppBar({
    super.key,
    required this.discoverStore,
  });

  final DiscoverStore discoverStore;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Discover'),
      leading: Observer(
        builder: (context) {
          return GestureDetector(
              onTap: () {
                discoverStore.updateSearch();
              },
              child: Icon(
                  discoverStore.isSearchEnabled ? Icons.close : Icons.search));
        },
      ),
      centerTitle: true,
      actions: [
        Observer(
          builder: (context) => InkWell(
            onTap: () {
              discoverStore.updateLayout();
            },
            child: Icon(
              discoverStore.isGridViewEnabled ? Icons.list : Icons.grid_3x3,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        )
      ],
    );
  }
}
