part of 'swipe_bloc.dart';

abstract class SwipePostState extends Equatable {
  const SwipePostState(this.posts, this.selectedPost, this.swiperController);

  final List<PostModel> posts;
  final int selectedPost;
  final AppinioSwiperController swiperController;

  @override
  List<Object> get props => [selectedPost, posts];
}

class SwipePostLoadingState extends SwipePostState {
  const SwipePostLoadingState(List<PostModel> posts, int selectedPost,
      AppinioSwiperController swiperController)
      : super(posts, selectedPost, swiperController);
}

class SwipePostErrorState extends SwipePostState {
  final String errorMessage;

  const SwipePostErrorState(this.errorMessage, List<PostModel> posts,
      int selectedPost, AppinioSwiperController swiperController)
      : super(posts, selectedPost, swiperController);
}

class SwipePostLoadedState extends SwipePostState {
  const SwipePostLoadedState(List<PostModel> posts, int selectedPost,
      AppinioSwiperController swiperController)
      : super(posts, selectedPost, swiperController);
}
