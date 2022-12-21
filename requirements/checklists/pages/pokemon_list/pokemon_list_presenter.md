# Pokemon List Presenter

> ## Rules
1. Check if the user has internet connection
2. Check if the Pokémon id is greater than 905 to update the link
3. ✅ Call LoadPokemon fetch 50 times on loadData method
4. ✅ Notify isLoadingStream as true before calling loadData method
5. ✅ Notify isLoadingStream as false at the end of loadData method
6. ✅ Notify pokemonStream with a Pokemon list if loadData succeeds
7. ✅ Notify pokemonStream with error if loadData returns error
8. Take the user to the Pokemon Details Page when clicking in a Pokemon