# FormavivaMmo

## Dev
To run the project in dev environment:

  * Install dependencies with `mix deps.get`
  * Make sure the database configuration in your config/dev.exs is correct for your local Postgres install
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and play the game.

## Tests
To run the project tests:
 * Install dependencies with `mix deps.get`
 * Make sure your MIX_ENV environment variable is set to "test"
 * Install dependencies with `mix deps.get`
 * Create and migrate your database with `mix ecto.setup`
 * Run the tests with `mix test`

## Build
To build a production release:
 * Make sure your MIX_ENV environment variable is set to "prod"
 * Make sure the database configuration in your config/test.exs is correct for your local Postgres install
 * Set your DATABASE_URL environment variable (E.g. `ecto://USER:PASS@HOST/DATABASE`)
 * Set the SECRET_KEY_BASE environment variable with your secret key base
 * run `mix release`