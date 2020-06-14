import 'package:bloc_getit_sample/bloc/word_provider.dart';
import 'package:bloc_getit_sample/widgets/bloc_favorite_page.dart';
import 'package:bloc_getit_sample/widgets/count_label.dart';
import 'package:bloc_getit_sample/widgets/word_list.dart';
import 'package:flutter/material.dart';

class RandomWordsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordBloc = WordProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          StreamBuilder<int>(
              stream: wordBloc.itemCount,
              initialData: 0,
              builder: (context, snapshot) => CountLabel(
                    favoriteCount: snapshot.data,
                  )),
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
