# README

## System version

  ```sh
    Ruby: 3.2.1
    Rails: 7.0.8.3
  ```

## System dependencies

  ```sh
    Rspec
    Factory_bot_rails
    Shoulda-matchers
  ```

## Configuration
  <p>
    To set up the project on your machine, ensure you have the required versions of Ruby and Rails installed. After cloning the project, run the following commands:
  </p>

  ```sh
    bundle install
    rails db:create
    rails db:migrate
    rails s
  ```

## Database creation
  To create the database, simply run:

 ```sh
    rails db:create 
    rails db:migrate
  ```

  These commands will initialize the database and run migrations.

## How to run the test suite
  To run the test suite, execute the following command:

  ```sh
    rspec 
    rails test
  ```

## Testing the System
  To test the system functionalities, follow these steps:

<strong>Creating an Account:</strong>

  ```sh
    Endpoint: POST /conta
    Input: JSON { "numero_conta": 234, "saldo": 180.37 }
    Expected Output:
    JSON { "numero_conta": 234, "saldo": 180.37 }
    return HTTP STATUS 201
  ```
  <strong>Performing a Transaction:</strong>

  ```sh
    Endpoint: POST /transacao 
    Input: JSON { "forma_pagamento": “D”, "numero_conta": 234, "valor":10 } 
    Expected Output: 
    JSON { "numero_conta": 234, "saldo": 170.07 }
    return HTTP STATUS 201 
    If the account does not have sufficient balance, it should 
    return HTTP STATUS 404. 
  ```

  <strong>Retrieving Account Information:</strong>

  ```sh
    Endpoint: GET /conta?numero_conta=234 
    Output: 
    If the account exists: 
    JSON {"numero_conta": 234, "saldo" : 170.07} 
    return HTTP STATUS 200 
    If the account does not exist: 
    return HTTP STATUS 404 
  ```
  Ensure that the system behaves as expected according to the provided 
  specifications for each step.


