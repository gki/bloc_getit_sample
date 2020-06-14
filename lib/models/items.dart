class WordItem extends Item {
  final String name;
  WordItem(this.name);

  @override
  String toString() => "$name";
}

class SuggestionItem extends Item {
  final String value;
  SuggestionItem(this.value);

  @override
  String toString() => "$value";
}

class AdItem extends Item {
  final String adMessage = "This is AD!";
}

abstract class Item {}
