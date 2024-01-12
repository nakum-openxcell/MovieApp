import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePoster extends StatefulWidget {
  const MoviePoster({
    super.key,
    required this.movie,
  });

  final MovieDetailsModel movie;

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  late final YoutubePlayerController _controller;

  final discoverStore = getIt.get<DiscoverStore>();

  @override
  void initState() {
    super.initState();
    discoverStore.getMovieTrailerId(movieId: widget.movie.id ?? 0);
    _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200.h,
          child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    player,
                  ],
                );
              }),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
