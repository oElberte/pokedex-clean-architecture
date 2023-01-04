Feature: Load Favorites
As a client
After tapping on the favorites page button
I want to see only my favorite Pokémon

Scenario: With internet
Given that the customer has an internet connection
When he tap on the favorites page button
Then the system should load the Pokémon favorites list
And the user can see all the Pokémon he favorited on this page

Scenario: Without internet
Given that the customer does not have an internet connection
When to request to see pokemons
Then the system should display an a error
And he will not be able to see the favorites list