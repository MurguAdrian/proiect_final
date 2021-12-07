import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:proiect_final/src/actions/get_movies.dart';
import 'package:proiect_final/src/container/is_loading_container.dart';
import 'package:proiect_final/src/container/titles_container.dart';
import 'package:proiect_final/src/models/app_state.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    final Store store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(GetMovies(onResult));

    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final double currentPosition = _controller.offset;
    final double maxPosition = _controller.position.maxScrollExtent;

    final Store<AppState> store = StoreProvider.of<AppState>(context);

    if (!store.state.isLoading && currentPosition > maxPosition) {
      store.dispatch(GetMovies(onResult));
    }
  }

  void onResult(dynamic action) {
    if (action is GetMoviesError) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error getting movies'),
            content: Text('${action.error}'),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IsLoadingContainer(
            builder: (BuildContext context, bool isLoading) {
              if (!isLoading) {
                return const SizedBox.shrink();
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      body: TitlesContainer(
        builder: (BuildContext context, List<String> titles) {
          return ListView.builder(
            controller: _controller,
            itemCount: titles.length,
            itemBuilder: (BuildContext context, int index) {
              final String title = titles[index];

              return ListTile(
                title: Text(title),
              );
            },
          );
        },
      ),
    );
  }
}
