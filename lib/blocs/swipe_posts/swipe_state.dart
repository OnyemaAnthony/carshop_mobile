part of 'swipe_bloc.dart';

enum PageStatus { initial, initializing, ready, error }

class SwipePostState extends Equatable {
  const SwipePostState(
      {required this.normalPosts,
      required this.deliveryPosts,
      required this.selectedPost,
      this.selectedDeliveryPost,
      this.selectedNormalPost,
      required this.pageStatus,
      this.successfulAction,
      this.errorMessage});

  final List<PublicNormalPostDescriptor> normalPosts;
  final List<PublicDeliveryPostDesc> deliveryPosts;
  final int selectedPost;
  final PublicNormalPostDescriptor? selectedNormalPost;
  final PublicDeliveryPostDesc? selectedDeliveryPost;
  final PageStatus pageStatus;
  final String? errorMessage;
  final SwipePostEvent? successfulAction; //any action to send to screen

  SwipePostState copyWith({
    List<PublicNormalPostDescriptor>? normalPosts,
    List<PublicDeliveryPostDesc>? deliveryPosts,
    int? selectedPost,
    PublicNormalPostDescriptor? selectedNormalPost,
    PublicDeliveryPostDesc? selectedDeliveryPost,
    PageStatus? pageStatus,
    String? errorMessage,
    SwipePostEvent? successfulAction,
  }) {
    return SwipePostState(
      normalPosts: normalPosts ?? this.normalPosts,
      deliveryPosts: deliveryPosts ?? this.deliveryPosts,
      selectedPost: selectedPost ?? this.selectedPost,
      selectedNormalPost: selectedNormalPost ?? this.selectedNormalPost,
      selectedDeliveryPost: selectedDeliveryPost ?? this.selectedDeliveryPost,
      pageStatus: pageStatus ?? this.pageStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      successfulAction: successfulAction ?? this.successfulAction,
    );
  }

  @override
  List<Object> get props => [
        selectedPost,
        normalPosts,
        selectedDeliveryPost?.isLiked ?? false,
        selectedNormalPost?.isLiked ?? false,
        pageStatus,
        successfulAction ?? "",
      ];
}
