part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPost extends PostEvent {
  const FetchPost();

  @override
  List<Object> get props => [];
}

class RefreshPost extends PostEvent {
  const RefreshPost();

  @override
  List<Object> get props => [];
}
