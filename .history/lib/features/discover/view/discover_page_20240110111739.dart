import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_grid_view.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_list_view.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({Key? key}) : super(key: key) {
    discoverStore.fetchMoviesRequested();
  }

  final discoverStore = getIt.get<DiscoverStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        leading: GestureDetector(
            onTap: () {
              discoverStore.isSearchEnabled = !discoverStore.isSearchEnabled;
            },
            child: Icon(
                discoverStore.isSearchEnabled ? Icons.close : Icons.search)),
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
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return discoverStore.fetchMoviesRequested();
        },
        child: Observer(
          builder: (context) {
            switch (discoverStore.discoverMovieModel.status) {
              case FutureStatus.pending:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case FutureStatus.rejected:
                return Center(
                  child:
                      Text(discoverStore.discoverMovieModel.error.toString()),
                );
              case FutureStatus.fulfilled:
                final DiscoverMovieModel movies =
                    discoverStore.discoverMovieModel.result;
                return Column(
                  children: [
                    //create search field with circular border and add search icon
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ))),
                    ),

                    SizedBox(height: 10.h),
                    discoverStore.isGridViewEnabled
                        ? Expanded(child: DiscoverGridView(movies: movies))
                        : Expanded(child: DiscoverListView(movies: movies))
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
