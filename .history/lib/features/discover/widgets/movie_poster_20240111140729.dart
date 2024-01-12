import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePoster extends StatelessWidget {
  MoviePoster({
    super.key,
    required this.movie,
  });

  final MovieDetailsModel movie;

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {},
          ),
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
