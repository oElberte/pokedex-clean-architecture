# Pokemon List Presenter

> ## Rules
1. Call LoadPokemonList, LoadPokemonResults, LoadPokemonDetails on loadData method
2. Notify isLoadingStream as true before calling LoadPokemon methods
3. Notify isLoadingStream as false at the end of LoadPokemon methods
4. Notify pokemonListStream with error if LoadPokemonList returns error
5. Notify pokemonDetailsStream with error if LoadPokemonDetails returns error
6. Notify pokemonListStream with a Pokemon list if LoadPokemonList succeeds
7. Notify pokemonDetailsStream with a Pokemon details list if LoadPokemonDetails succeeds
8. Take the user to the Pokemon Details Page when clicking in a Pokemon