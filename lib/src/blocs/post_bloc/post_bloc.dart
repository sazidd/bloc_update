import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/post_model.dart';
import '../../repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({this.postRepository}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchPost && !_hasReachedMax(state)) {
      if (currentState is PostInitial) {
        yield PostLoading();
        try {
          final posts = await postRepository.fetchPost(0, 10);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        } catch (_) {
          yield PostError();
        }
      } else if (currentState is PostLoaded) {
        try {
          final posts =
              await postRepository.fetchPost(currentState.posts.length, 10);

          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        } catch (_) {
          yield PostError();
        }
      }
    } else if (event is RefreshPost) {
      try {
        yield PostLoaded(posts: []);
        yield PostLoading();
        final posts = await postRepository.fetchPost(0, 10);
        yield PostLoaded(posts: posts, hasReachedMax: false);
      } catch (_) {
        yield PostError();
      }
    }
  }
}

bool _hasReachedMax(PostState state) =>
    state is PostLoaded && state.hasReachedMax;
