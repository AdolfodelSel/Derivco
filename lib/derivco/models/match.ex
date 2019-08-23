defmodule Derivco.Models.Match do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matches" do
    field :date, :string
    belongs_to :home_team, Derivco.Models.Team, foreign_key: :home_team_id
    belongs_to :away_team, Derivco.Models.Team, foreign_key: :away_team_id
    field :fthg, :integer
    field :ftag, :integer
    field :ftr, :string
    field :hthg, :integer
    field :htag, :integer
    field :htr, :string
    belongs_to :season, Derivco.Models.Season, foreign_key: :season_id
    belongs_to :division, Derivco.Models.Division, foreign_key: :division_id
    timestamps()
  end

  def changeset(results, attrs) do
    results
    |> cast(attrs, [:date, :home_team_id, :away_team_id, :fthg, :ftag, :ftr, :hthg, :htag, :htr, :season_id, :division_id])
    |> validate_required([:date, :home_team_id, :away_team_id, :fthg, :ftag, :ftr, :hthg, :htag, :htr, :season_id, :division_id])
  end

  def get_empty_map() do
    %Derivco.Models.Match{}
  end
end
