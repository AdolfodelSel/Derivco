defmodule Derivco.Models.Season do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seasons" do
    field :name, :string
    has_many :matches, Derivco.Models.Match
    timestamps()
  end

  def changeset(results, attrs) do
    results
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def get_empty_map() do
    %Derivco.Models.Season{}
  end
end
