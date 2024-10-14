import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:thai_journey_app/main.dart" as app;
import "package:thai_journey_app/screens/attraction_detail_screen.dart";
import "package:thai_journey_app/screens/favourite_screen.dart";
import "package:thai_journey_app/screens/place_search_screen.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test full app', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final favbutton1 = find.byType(InkWell).at(0);
    final favbutton2 = find.byType(InkWell).at(1);
    final favbutton3 = find.byType(InkWell).at(2);
    final favbutton4 = find.byType(InkWell).at(3);

    Future.delayed(const Duration(seconds: 10));
    await tester.tap(favbutton1);
    Future.delayed(const Duration(seconds: 5));
    await tester.tap(favbutton2);
    Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsAny);
    Future.delayed(const Duration(seconds: 5));

    await tester.tap(find.byKey(Key('Fav')));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 10));
    expect(find.byType(FavouriteScreen), findsOne);
    Future.delayed(const Duration(seconds: 10));

    await tester.tap(find.byType(Card).at(0));
    Future.delayed(const Duration(seconds: 20));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 20));
    expect(find.byType(AttractionDetailScreen), findsOne);
    expect(find.byIcon(Icons.favorite), findsAny);
    // expect(find.image(skipOffstage: true), findsOne);
    expect(find.text("รายละเอียด"), findsOne);

    await tester.tap(find.byKey(Key('FavAttractionButton')));
    Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 10));

    await tester.tap(find.byKey(Key('AttractionBack')));
    Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 10));
    expect(find.byType(FavouriteScreen), findsOne);
    Future.delayed(const Duration(seconds: 10));

    await tester.tap(find.byKey(Key('Home')));
    Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 10));

    final searchBox = find.byKey(Key('SearchBox'));
    await tester.enterText(searchBox, "กรุง");
    Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text("กรุงเทพมหานคร"), findsAny);
    await tester.tap(find.text("กรุงเทพมหานคร"));
    Future.delayed(const Duration(seconds: 30));
    await tester.pumpAndSettle();

    Future.delayed(const Duration(seconds: 30));
    expect(find.byType(PlaceSearchScreen), findsOne);
    Future.delayed(const Duration(seconds: 15));

    await tester.tap(find.byType(Card).at(0));
    Future.delayed(const Duration(seconds: 20));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 20));
    expect(find.byType(AttractionDetailScreen), findsOne);
    expect(find.byIcon(Icons.favorite), findsAny);
    // expect(find.image(skipOffstage: true), findsOne);
    expect(find.text("รายละเอียด"), findsOne);

    await tester.tap(find.byKey(Key('FavAttractionButton')));
    Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 10));

    await tester.tap(find.byKey(Key('AttractionBack')));
    Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    Future.delayed(const Duration(seconds: 10));
    expect(find.byType(PlaceSearchScreen), findsOne);
    Future.delayed(const Duration(seconds: 10));
    expect(find.byType(Card), findsAtLeast(1));
  });

  // testWidgets('Test full app', (WidgetTester tester) async {
  //   app.main();
  //   await tester.pumpAndSettle();
  //   final searchBox = find.byKey(Key('SearchBox'));

  //   //enter text in searchbox
  //   Future.delayed(const Duration(seconds: 5));
  //   await tester.enterText(searchBox, "กรุง");
  //   Future.delayed(const Duration(seconds: 5));
  //   await tester.pumpAndSettle();
  //   expect(find.text("กรุงเทพมหานคร"), findsAny);
  //   await tester.tap(find.text("กรุงเทพมหานคร"));
  //   Future.delayed(const Duration(seconds: 5));
  //   await tester.pumpAndSettle();

  //   Future.delayed(const Duration(seconds: 5));
  //   expect(find.byType(PlaceSearchScreen), findsOne);
  //   Future.delayed(const Duration(seconds: 5));

  //   await tester.tap(find.byType(Card).at(0));
  //   Future.delayed(const Duration(seconds: 5));
  //   await tester.pumpAndSettle();

  //   expect(find.byType(AttractionDetailScreen), findsOne);
  //   Future.delayed(const Duration(seconds: 5));

  //   expect(find.text("รายละเอียด"), findsOne);
  //   Future.delayed(const Duration(seconds: 5));
  //   // expect(find.byType(Image), findsAtLeast(5));
  // });
}
