part of 'create_delivery_post_bloc.dart';
@immutable

class CreateDeliveryPostState extends Equatable {
final String? title ;
final String? description ;
 double pageNum  = 1/4 ;

  CreateDeliveryPostState({ required this.title, required this.description,required this.pageNum});

  CreateDeliveryPostState copyWith({
  String? title,
  String? description,
    required double pageNum,
}) {
  return CreateDeliveryPostState(
      title: title ?? this.title,
      description: description ?? this.description,
      pageNum: pageNum = this.pageNum,
      );
  }

  @override
  List<Object> get props => [pageNum];
}




