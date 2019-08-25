defmodule Derivco.Models.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string
    has_many :matchs_home, Derivco.Models.Match, foreign_key: :home_team_id
    has_many :matchs_away, Derivco.Models.Match, foreign_key: :away_team_id
    timestamps()
  end

  @doc false
  def changeset(results, attrs) do
    results
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def get_empty_map() do
    %Derivco.Models.Team{}
  end
end
