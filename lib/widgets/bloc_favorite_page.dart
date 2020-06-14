import 'dart:async';

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

  List<Item> wordItemList;
  bool withInfo = true;
  StreamSubscription<List<Item>> _subscription;

  @override
  void initState() {
    super.initState();
    _setupSubscription();
  }

  _setupSubscription() {
    if (_subscription != null) {
      _subscription.cancel();
    }
    if (withInfo) {
      _subscription = wordBloc.itemsWithInfo().listen((items) {
        setState(() {
          wordItemList = items;
        });
      });
    } else {
      _subscription = wordBloc.items.listen((items) {
        setState(() {
          wordItemList = items;
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Favorite"),
          actions: <Widget>[
            Center(child: Text('Info')),
            new Switch(
              value: withInfo,
              onChanged: (v) {
                setState(() {
                  withInfo = v;
                  _setupSubscription();
                });
              },
            )
          ],
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    if (wordItemList == null || wordItemList.isEmpty) {
      return Center(child: Text('Empty'));
    }

    final tiles = wordItemList.map((item) {
      switch (item.type) {
        case ItemType.word:
          final word = item as WordItem;
          return new ListTile(
            title: new Text(word.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => wordBloc.wordRemoval.add(WordRemoval(word.name)),
            ),
          );
        case ItemType.suggestion:
          return Container(
            color: Colors.cyan,
            child: ListTile(
                title:
                    new Text('Suggestion! ${(item as SuggestionItem).value}')),
          );
        case ItemType.ad:
          return Container(
            color: Colors.amber,
            child: ListTile(title: Text((item as AdItem).adMessage)),
          );
      }
    });

    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new ListView(children: divided);
  }
}
