# Pokemon List Presenter

> ## Rules
1. Check if the user has internet connection
2. Check for duplicated pokémons on the list
3. Check if the Pokémon id is greater than 905 to update the link
4. ✅ Call LoadPokemon fetch 50 times on loadData method
5. ✅ Notify isLoadingStream as true before calling loadData method
6. ✅ Notify isLoadingStream as false at the end of loadData method
7. ✅ Notify pokemonStream with a Pokemon list if loadData succeeds
8. ✅ Notify pokemonStream with error if loadData returns error
9. Add Pokémon to favorites on favorite button pressed
10. ✅ Take the user to other pages when clicking in a button