import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_repository.dart';
import 'movies_cubit.dart';
import 'movies_state.dart';

class BlocCubitPage extends StatefulWidget {
  @override
  _BlocCubitPageState createState() => _BlocCubitPageState();
}

class _BlocCubitPageState extends State<BlocCubitPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MoviesCubit(repository: MovieRepository()),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Trending Movies'),
            ),
            body: CustomScrollView(
              slivers: [
                 const SliverToBoxAdapter(
                  child: SizedBox(),
                ),
                BlocBuilder<MoviesCubit, MoviesState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is ErrorState) {
                      return  const SliverToBoxAdapter(
                        child: Center(
                          child: Icon(Icons.close),
                        ),
                      );
                    } else if (state is LoadedState) {
                      final movies = state.movies;
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(movies[index].title),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(movies[index].urlImage),
                              ),
                            ),
                          );
                        },
                        childCount: movies.length, // 1000 list items
                      ));
                    } else {
                      return SliverToBoxAdapter(child: Container());
                    }
                  },
                )
              ],
            ),
          );
        }));
  }
}
