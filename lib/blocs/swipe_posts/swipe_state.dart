part of 'swipe_bloc.dart';

enum PageStatus { initial, initializing, ready, loading, error }

enum SwipeBlocMessages {
  postLiked,
  postDisliked,
  failedToLikePost,
  failedToDislikePost,
  deliveryPostAccepted,
  deliveryPostAcceptionFailed,
  postRefreshed,
  failedToRefreshPost,
  postDeleted,
  failedToDeletePost,
}

class SwipePostState extends Equatable {
  const SwipePostState(
      {required this.normalPosts,
      required this.deliveryPosts,
      required this.normalPostId,
      required this.deliveryPostId,
      required this.pageStatus,
      required this.message,
      required this.errorMessage});

  final List<PublicNormalPostDescriptor> normalPosts;
  final List<PublicDeliveryPostDesc> deliveryPosts;
  final int normalPostId;
  final int deliveryPostId;
  final PageStatus pageStatus;
  final String? errorMessage;
  final SwipeBlocMessages? message; //any action to send to screen
  PublicNormalPostDescriptor? get selectedNormalPost =>
      normalPostId < normalPosts.length ? normalPosts[normalPostId] : null;

  PublicDeliveryPostDesc? get selectedDeliveryPost =>
      normalPostId < deliveryPosts.length ? deliveryPosts[normalPostId] : null;

  SwipePostState copyWith({
    List<PublicNormalPostDescriptor>? normalPosts,
    List<PublicDeliveryPostDesc>? deliveryPosts,
    int? normalPostId,
    int? deliveryPostId,
    int? toUpdateNormalPostId,
    PublicNormalPostDescriptor? updatedSelectedNormalPost,
    int? toUpdateDeliveryPostId,
    PublicDeliveryPostDesc? updatedSelectedDeliveryPost,
    PageStatus? pageStatus,
    String? errorMessage,
    SwipeBlocMessages? message,
  }) {
    List<PublicNormalPostDescriptor>? updatedNormalPosts;

    if (updatedSelectedNormalPost != null &&
        toUpdateNormalPostId != null &&
        toUpdateNormalPostId < this.normalPosts.length) {
      updatedNormalPosts = List.from(this.normalPosts);
      updatedNormalPosts[toUpdateNormalPostId] = updatedSelectedNormalPost;
    }

    List<PublicDeliveryPostDesc>? updatedDeliveryPosts;

    if (updatedSelectedDeliveryPost != null &&
        toUpdateDeliveryPostId != null &&
        toUpdateDeliveryPostId < this.deliveryPosts.length) {
      updatedDeliveryPosts = List.from(this.deliveryPosts);
      updatedDeliveryPosts[toUpdateDeliveryPostId] =
          updatedSelectedDeliveryPost;
    }

    return SwipePostState(
      normalPosts: normalPosts ?? updatedNormalPosts ?? this.normalPosts,
      deliveryPosts:
          deliveryPosts ?? updatedDeliveryPosts ?? this.deliveryPosts,
      normalPostId: normalPostId ?? this.normalPostId,
      deliveryPostId: deliveryPostId ?? this.deliveryPostId,
      pageStatus: pageStatus ?? PageStatus.ready,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message,
    );
  }

  @override
  List<Object> get props => [
        normalPostId,
        deliveryPostId,
        normalPosts,
        deliveryPosts,
        pageStatus,
        message ?? "",
      ];
}
