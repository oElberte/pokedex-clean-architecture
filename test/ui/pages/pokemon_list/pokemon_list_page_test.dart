import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokedex_clean_architecture/ui/pages/pages.dart';

import 'pokemon_list_page_test.mocks.dart';

void main() {
  late MockPokemonListPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockPokemonListPresenter();
    final pokemonListPage = GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => PokemonListPage(presenter),
        ),
      ],
    );
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(pokemonListPage);
    });
  }

  testWidgets('Shoud call LoadData on page load', (WidgetTester tester) async {
    loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
}
