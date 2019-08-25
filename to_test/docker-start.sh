#!/bin/bash
mix deps.get && iex --name derivco@127.0.0.1 --cookie derivco_cookie -S mix phx.server