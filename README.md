# BLOC & get_it Sample

This source is based on [this repository](https://github.com/sensuikan1973/Flutter_RxDart_GetStarted) and update to understand GetIt.

The original repo author is also introduced own idea in [this Qiita](https://qiita.com/sensuikan1973/items/64f1a6235bd8ecaf9067) article. (Only Japanese)


# Why I create this?

I'm learning and developing Flutter app. Recently I was struggling with DI in my flutter app. In internet, there are many info for DI on flutter and the majority seems [provider packege](https://pub.dev/packages/provider) and `InheritedWidget`. However, I was having some strange feeling for them because they seemed tightly integrated Widget tree. And I don't want to think the context of the widget tree when obtaining an instance which is widely needed from any widget or business logic.

One day, I found [get_it packege](https://pub.dev/packages/get_it) ad another candidate for DI in my flutter app.

Thus, I tried to understand to update from an example app which is using `InheritedWidget` to new way using `get_it` package.

# App UI

## Startup Name Generator Page
This is 1st screen of this app. User can see random words in the list and can mark as "Favorite".

User can see total number of favorites on the navigation bar and it will be updated by adding or removing favorites.

From an icon button on the navigation bar, user can move 2nd page: Your Favorite page.

## Your Favorite page
User can review own favorite words in the list.
As default, the list include a dummy suggestion item at the first place of the list. Also, dummy ad Views will be shown as items of the list.

User can disable to show the dummy suggestion item and dummy ad views by using a switch on the navigation bar.

Also, user can remove favorites from the delete icon button for each favorite item, if user doesn't like it any more.

# What I updated from the original repo.
1. File structure upadte.
1. Add some debug log.
1. Use get_it package
    1. Add initialization step in `main.dart`.
    1. Remove logic using `WordBlocProvider` class which was a subclass of `InheritedWidget`.
    1. Use `GetIt.I<WordBloc>()` instead of the Provider class.
    1. Refactor some methods to not use `WordBloc` as an argument because any logic can get `WordBloc` instance from GetIt.
1. In Your Favorite Page, added delete icon button for each `ListTile` and call remove function of `WordBloc` when tapped.
1. Add new getter `itemsWithInfo` in `WordBloc` to provide `Stream` for prividing a list including all of favorited words, one suggestion and ads. This stream is created by `transform`ing streams, from the original stream: `Stream<List<WordItem>>`.
