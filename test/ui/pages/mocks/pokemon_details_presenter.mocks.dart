// Mocks generated by Mockito 5.3.2 from annotations
// in pokedex/test/ui/pages/pokemon_details/pokemon_details_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pokedex/ui/pages/pokemon_details/pokemon_details_presenter.dart'
    as _i3;

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

class _FakeWidget_0 extends _i1.SmartFake implements _i2.Widget {
  _FakeWidget_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i2.DiagnosticLevel? minLevel = _i2.DiagnosticLevel.info}) =>
      super.toString();
}

/// A class which mocks [PokemonDetailsPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonDetailsPresenter extends _i1.Mock
    implements _i3.PokemonDetailsPresenter {
  @override
  void onFavoritePress(int? index) => super.noSuchMethod(
        Invocation.method(
          #onFavoritePress,
          [index],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.Widget getIcon(int? index) => (super.noSuchMethod(
        Invocation.method(
          #getIcon,
          [index],
        ),
        returnValue: _FakeWidget_0(
          this,
          Invocation.method(
            #getIcon,
            [index],
          ),
        ),
        returnValueForMissingStub: _FakeWidget_0(
          this,
          Invocation.method(
            #getIcon,
            [index],
          ),
        ),
      ) as _i2.Widget);
  @override
  int getBoxIndex(int? index) => (super.noSuchMethod(
        Invocation.method(
          #getBoxIndex,
          [index],
        ),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
}
