import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/blocs/post_bloc/post_bloc.dart';
import 'src/repository/post_repository.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => PostBloc(postRepository: PostRepository())..add(FetchPost()),
    child: App(),
  ));
}
