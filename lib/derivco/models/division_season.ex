defmodule Derivco.Models.DivisionSeason do
  use Ecto.Schema
  import Ecto.Changeset

  schema "division_seasons" do
    belongs_to :season, Derivco.Models.Season, foreign_key: :season_id
    belongs_to :division, Derivco.Models.Division, foreign_key: :division_id
    timestamps()
  end

  def changeset(results, attrs) do
    results
    |> cast(attrs, [:season_id, :division_id])
    |> validate_required([:season_id, :division_id])
  end

  def get_empty_map() do
    %Derivco.Models.DivisionSeason{}
  end
end
