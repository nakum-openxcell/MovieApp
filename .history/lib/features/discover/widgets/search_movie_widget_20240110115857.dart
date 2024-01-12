import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

class SearchMovieWidget extends StatelessWidget {
  SearchMovieWidget(
      {super.key,
      required this.discoverStore,
      required this.searchEC,
      required this.onSearchChanged});

  DiscoverStore discoverStore;
  TextEditingController searchEC;
  void Function({required String value}) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          Visibility(
            visible: discoverStore.isSearchEnabled,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: 55.h,
                child: TextField(
                  controller: searchEC,
                  onChanged: (value) {
                    onSearchChanged(value: value);
                  },
                  onSubmitted: (value) {
                    onSearchChanged(value: value);
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
          ),
          SizedBox(height: 10.h),
        ],
      );
    });
  }
}
