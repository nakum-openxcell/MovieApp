import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_app_bar.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_grid_view.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_list_view.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final discoverStore = getIt.get<DiscoverStore>();
  Timer? _debounce;
  TextEditingController searchEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    discoverStore.fetchMoviesRequested();
  }

  void _onSearchChanged({required String value}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      await discoverStore
          .searchMovies(query: value)
          .then((value) => {searchEC.text = value});
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: DiscoverAppBar(
          discoverStore: discoverStore,
        ),
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
                    SearchMovieWidget(
                      discoverStore: discoverStore,
                      searchEC: searchEC,
                      onSearchChanged: _onSearchChanged,
                      
                    )
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

class SearchMovieWidget extends StatelessWidget {
   SearchMovieWidget({super.key, required  this.discoverStore, required this.searchEC, required this.onSearchChanged});

  DiscoverStore discoverStore;
  TextEditingController searchEC;
  void Function({required String value}) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: discoverStore.isSearchEnabled,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SizedBox(
          height: 55.h,
          child: TextField(
            controller: searchEC,
            onChanged: (value) {
              _onSearchChanged(value: value);
            },
            onSubmitted: (value) {
              _onSearchChanged(value: value);
            },
            style: TextStyle(fontSize: 15.sp, height: 20 / 15),
            cursorHeight: 20.h,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
