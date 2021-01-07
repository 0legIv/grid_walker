# GridWalker

To start the application in dev environment:

  * `mix deps.get`
  * `cd assets && npm install`
  * `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To run tests:

  * `mix deps.get`
  * `mix test`

to build release:

  * in the root directory: `docker build -t grid_walker .`
  * `docker run -i -t -p 4000:4000 -e PORT=4000 -e HOST=localhost grid_walker:latest`
  * Now you can visit `http://localhost:4000`
