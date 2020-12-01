import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_bloc/post_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollControllerPosts = ScrollController();
  final _scrollControllerTodos = ScrollController();
  final _scrollThreshold = 200.0;

  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollControllerPosts.addListener(_onScroll);
    _postBloc = context.read<PostBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollControllerPosts.dispose();
    _scrollControllerTodos.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _postBloc.add(RefreshPost());
            },
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PostError) {
            return Center(
                child: Text(
              'failed to fetch posts',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ));
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text(
                  'No data found!',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                controller: _scrollControllerPosts,
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: SizedBox(
                              width: 33,
                              height: 33,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            ),
                          ),
                        )
                      : ListTile(
                          leading: Text('${state.posts[index].id}'),
                          title: Text(state.posts[index].title),
                          isThreeLine: true,
                          subtitle: Text(state.posts[index].body),
                          dense: true,
                        );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _onScroll() {
    final maxScrollPosts = _scrollControllerPosts.position.maxScrollExtent;
    final currentScrollPosts = _scrollControllerPosts.position.pixels;
    if (maxScrollPosts - currentScrollPosts <= _scrollThreshold) {
      _postBloc.add(FetchPost());
    }
  }

  Future<Null> _onRefresh() async => _postBloc.add(RefreshPost());
}
