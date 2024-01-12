class MovieDetails extends StatelessWidget {
  const MovieDetails({
    super.key,
    required this.movie,
  });

  final MovieDetailsModel movie;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title ?? '',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gap(10.h),
              Text(
                '⭐️ ${movie.voteAverage?.toStringAsFixed(1) ?? ''}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 50.h,
                child: ListView.separated(
                  itemCount: movie.genres?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(10.w);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Chip(label: Text(movie.genres?[index].name ?? ''));
                  },
                ),
              ),
              Gap(10.h),
              Text('Storyline', style: Theme.of(context).textTheme.titleLarge),
              Gap(10.h),
              Text(
                movie.overview ?? '',
              )
            ],
          ),
        ),
      ),
    );
  }
}
