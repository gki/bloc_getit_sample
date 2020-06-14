import 'package:bloc_getit_sample/bloc/word_bloc.dart';
import 'package:bloc_getit_sample/models/word_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class BlocFavoritePage extends StatefulWidget {
  BlocFavoritePage();

  static const routeName = "/favorite";

  @override
  _BlocFavoritePageState createState() => _BlocFavoritePageState();
}

class _BlocFavoritePageState extends State<BlocFavoritePage> {
  final WordBloc wordBloc = GetIt.I<WordBloc>();
  List<WordItem> wordItemList;

  @override
  void initState() {
    super.initState();
    wordBloc.items.listen((items) {
      setState(() {
        wordItemList = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Favorite"),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    if (wordItemList.isEmpty) {
      return Center(child: Text('Empty'));
    }

    final tiles = wordItemList.map((item) {
      return new ListTile(
        title: new Text(item.name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => wordBloc.wordRemoval.add(WordRemoval(item.name)),
        ),
      );
    });

    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new ListView(children: divided);
  }
}
