Feature: Load Pokémon List
As a client
I want to see all the Pokémons
To be able to see the details of each one

Scenario: With internet
Given that the customer has an internet connection
When to request to see pokémons
Then the system should display the pokemons

Scenario: Without internet
Given that the customer does not have an internet connection
When to request to see pokemons
Then the system should display an a error