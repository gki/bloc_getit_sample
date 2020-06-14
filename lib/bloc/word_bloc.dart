import 'dart:async';

import 'package:bloc_getit_sample/models/word.dart';
import 'package:bloc_getit_sample/models/items.dart';
import 'package:rxdart/subjects.dart';

class WordAddition {
  final String name;
  WordAddition(this.name);
}

class WordRemoval {
  final String name;
  WordRemoval(this.name);
}

class WordBloc {
  final Word _word = Word();

  final BehaviorSubject<List<WordItem>> _items =
      BehaviorSubject<List<WordItem>>.seeded([]);

  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);

  final StreamController<WordAddition> _wordAdditionController =
      StreamController<WordAddition>();

  final StreamController<WordRemoval> _wordRemovalController =
      StreamController<WordRemoval>();

  WordBloc() {
    _wordAdditionController.stream.listen((addition) {
      int currentCount = _word.itemCount;
      _word.add(addition.name);
      print('added ${_word.items.toString()}');
      _items.add(_word.items);
      int updateCount = _word.itemCount;
      if (updateCount != currentCount) {
        _itemCount.add(updateCount);
      }
    });

    _wordRemovalController.stream.listen((removal) {
      int currentCount = _word.itemCount;
      _word.remove(removal.name);
      print('removed ${_word.items.toString()}');
      _items.add(_word.items);
      int updateCount = _word.itemCount;
      if (updateCount != currentCount) {
        _itemCount.add(updateCount);
      }
    });
  }

  Sink<WordAddition> get wordAddition => _wordAdditionController.sink;

  Sink<WordRemoval> get wordRemoval => _wordRemovalController.sink;

  Stream<int> get itemCount => _itemCount.stream;

  Stream<List<WordItem>> get items => _items.stream;

  // NOTE: 本当はgetterにしたいけど<T extends Item>みたいな書き方が出来ない。
  // Stream<List<Item>> get itemsWithInfo<T extends Item> {
  //   return _items.stream.transform(insertInfo());
  // }

  Stream<List<T>> itemsWithInfo<T extends Item>() {
    return _items.stream.transform(insertInfo());
  }

  final _adInterval = 5;

  StreamTransformer<List<WordItem>, List<T>> insertInfo<T extends Item>() {
    return StreamTransformer<List<WordItem>, List<T>>.fromHandlers(
        handleData: (value, sink) {
      // 最初にSuggestionを入れる
      final itemsWithInfo = <Item>[SuggestionItem("You might like FooBar!")];
      // 途中に広告を入れる
      if (value.length <= _adInterval) {
        itemsWithInfo
          ..addAll(value)
          ..add(AdItem());
      } else {
        for (int i = 0; i < value.length; i++) {
          if (i > 0 && i % _adInterval == 0) {
            itemsWithInfo.add(AdItem());
          }
          itemsWithInfo.add(value[i]);
        }
      }
      sink.add(itemsWithInfo);
    });
  }

  void dispose() {
    _items.close();
    _itemCount.close();
    _wordAdditionController.close();
    _wordRemovalController.close();
  }
}
