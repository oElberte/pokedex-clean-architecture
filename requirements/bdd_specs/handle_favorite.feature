Feature: Handle Favorite
As a client
After tapping on the favorite button
I want to add or remove the specific Pokémon of my favorite list

Scenario: With internet
Given that the customer has an internet connection
When he tap on the favorite button
Then the system should add or remove the Pokémon to the favorites page

Scenario: Without internet
Given that the customer does not have an internet connection
When to request to see pokemons
Then the system should display an a error
And he will not be able to add or remove the Pokémon to favorites list