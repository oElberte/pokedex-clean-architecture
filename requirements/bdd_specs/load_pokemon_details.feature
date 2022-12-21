Feature: Load Pokémon Details
As a client
After tapping on a Pokémon
I want to see the details of him

Scenario: With internet
Given that the customer has an internet connection
When he tap in a specific Pokémon
Then the system should display the details of this Pokémon

Scenario: Without internet
Given that the customer does not have an internet connection
When to request to see pokemons
Then the system should display an a error
And he will not be able to tap in the Pokémon to see the details