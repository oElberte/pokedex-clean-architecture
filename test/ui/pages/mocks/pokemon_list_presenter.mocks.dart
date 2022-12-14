// Mocks generated by Mockito 5.3.2 from annotations
// in pokedex/test/ui/pages/pokemon_list/pokemon_list_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:pokedex/ui/components/pokemon_viewmodel.dart' as _i4;
import 'package:pokedex/ui/pages/pokemon_list/pokemon_list_presenter.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [PokemonListPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonListPresenter extends _i1.Mock
    implements _i2.PokemonListPresenter {
  MockPokemonListPresenter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<_i4.PokemonViewModel>> get pokemonStream =>
      (super.noSuchMethod(
        Invocation.getter(#pokemonStream),
        returnValue: _i3.Stream<List<_i4.PokemonViewModel>>.empty(),
      ) as _i3.Stream<List<_i4.PokemonViewModel>>);
  @override
  _i3.Stream<bool> get isLoadingStream => (super.noSuchMethod(
        Invocation.getter(#isLoadingStream),
        returnValue: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);
  @override
  _i3.Stream<String?> get navigateToStream => (super.noSuchMethod(
        Invocation.getter(#navigateToStream),
        returnValue: _i3.Stream<String?>.empty(),
      ) as _i3.Stream<String?>);
  @override
  _i3.Future<void> loadData() => (super.noSuchMethod(
        Invocation.method(
          #loadData,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void navigateTo(String? page) => super.noSuchMethod(
        Invocation.method(
          #navigateTo,
          [page],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void goToDetails() => super.noSuchMethod(
        Invocation.method(
          #goToDetails,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
