defmodule DerivcoWeb.Router do
  use DerivcoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DerivcoWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/lists", DerivcoWeb do
    pipe_through :api

    get "/divisions_seasons", ListController, :divisions_seasons
    get "/divisions_teams", ListController, :divisions_teams
    get "/seasons_teams", ListController, :seasons_teams
  end

  scope "/divisions", DerivcoWeb do
    pipe_through :api

    get "/", DivisionController, :all
    get "/:division_id/seasons", DivisionController, :linked_seasons
    get "/:division_id/matches", DivisionController, :linked_matches
    get "/:division_id/seasons/:season_id/matches", DivisionController, :linked_seasons_matches
  end

  scope "/seasons", DerivcoWeb do
    pipe_through :api

    get "/", SeasonController, :all
    get "/:season_id/divisions", SeasonController, :linked_divisions
    get "/:season_id/matches", SeasonController, :linked_matches
  end

  scope "/teams", DerivcoWeb do
    pipe_through :api

    get "/", TeamController, :all
  end

  scope "/matches", DerivcoWeb do
    pipe_through :api

    get "/", MatchController, :all
    get "/:match_id", MatchController, :single_match
  end

  scope "/", DerivcoWeb do
    pipe_through :browser

    get "/*path", ErrorController, :four_oh_four
  end
end
