# Pokemon Favorites Presenter

> ## Rules
1. Call LoadPokemon fetch for all the favorites on loadFavorites method
2. Notify isLoadingStream as true before calling loadFavorites method
3. Notify isLoadingStream as false at the end of loadFavorites method
4. Return a Pokemon list if loadFavorites succeeds
5. Throw a error if loadFavorites returns error
6. Show a message if the favorite list is empty