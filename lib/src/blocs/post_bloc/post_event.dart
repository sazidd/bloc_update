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

class FetchSpecificPost extends PostEvent {
  final String userId;

  const FetchSpecificPost(this.userId);

  FetchSpecificPost copyWith({
    String userId,
  }) {
    return FetchSpecificPost(
      userId ?? this.userId,
    );
  }

  @override
  List<Object> get props => [userId];
}

class RefreshPost extends PostEvent {
  const RefreshPost();

  @override
  List<Object> get props => [];
}
