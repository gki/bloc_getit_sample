import 'package:bloc_getit_sample/bloc/word_bloc.dart';
import 'package:bloc_getit_sample/models/suggestion.dart';
import 'package:bloc_getit_sample/models/word_item.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class WordList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          if (index >= suggestion.suggestionCount) {
            const addNum = 10;
            suggestion.addMulti(generateWordPairs().take(addNum).toList());
          }
          return _buildRow(
              GetIt.I<WordBloc>(), suggestion.suggestedWords[index]);
        });
  }
}

// Favorite済み、すなわちword.itemsに含まれていれば、赤いハートアイコンにする
Widget _buildRow(WordBloc word, WordPair pair) {
  return new StreamBuilder<List<WordItem>>(
      stream: word.items,
      builder: (_, snapshot) {
        if (snapshot.data == null || snapshot.data.isEmpty) {
          return _createWordListTile(word, false, pair.asPascalCase);
        } else {
          final alreadyAdded = snapshot.data.fold(
              false,
              (prevResult, item) =>
                  prevResult || item.name == pair.asPascalCase);
          return _createWordListTile(word, alreadyAdded, pair.asPascalCase);
        }
      });
}

ListTile _createWordListTile(WordBloc word, bool isFavorited, String title) {
  print('_createWordListTile $word $isFavorited $title');
  return new ListTile(
    key: Key(title),
    title: new Text(title),
    trailing: new Icon(
      isFavorited ? Icons.favorite : Icons.favorite_border,
      color: isFavorited ? Colors.red : null,
    ),
    onTap: () {
      if (isFavorited) {
        word.wordRemoval.add(WordRemoval(title));
      } else {
        word.wordAddition.add(WordAddition(title));
      }
    },
  );
}
