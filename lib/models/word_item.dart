class WordItem extends Item {
  final String name;
  WordItem(this.name);

  @override
  String toString() => "$name";

  @override
  ItemType get type => ItemType.word;
}

class SuggestionItem extends Item {
  final String value;
  SuggestionItem(this.value);

  @override
  String toString() => "$value";

  @override
  ItemType get type => ItemType.suggestion;
}

class AdItem extends Item {
  final String adMessage = "This is AD!";

  @override
  ItemType get type => ItemType.ad;
}

abstract class Item {
  ItemType get type;
}

enum ItemType {
  word,
  suggestion,
  ad,
}
