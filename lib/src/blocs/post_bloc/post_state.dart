part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {
  const PostInitial();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  const PostLoading();

  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<PostModel> posts;
  final bool hasReachedMax;

  const PostLoaded({
    this.posts,
    this.hasReachedMax,
  });

  PostLoaded copyWith({
    List<PostModel> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];
}

class PostError extends PostState {
  final String error;
  const PostError({this.error});

  @override
  List<Object> get props => [error];
}
