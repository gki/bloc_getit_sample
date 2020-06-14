import 'package:bloc_getit_sample/widgets/bloc_favorite_page.dart';
import 'package:bloc_getit_sample/widgets/count_label.dart';
import 'package:bloc_getit_sample/widgets/word_list.dart';
import 'package:flutter/material.dart';

class RandomWordsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          CountLabel(),
          new IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).pushNamed(BlocFavoritePage.routeName);
              })
        ],
      ),
      body: WordList(),
    );
  }
}
