defmodule Derivco.Repo.Migrations.CreateDatabase do
  use Ecto.Migration

  def change do
    create table(:divisions) do
      add :name, :string
      timestamps()
    end

    create table(:seasons) do
      add :name, :string
      timestamps()
    end

    create table(:division_seasons) do
      add :division_id, references(:divisions)
      add :season_id, references(:seasons)
      timestamps()
    end

    create table(:teams) do
      add :name, :string
      timestamps()
    end

    create table(:matches) do
      add :date, :string
      add :season_id, references(:seasons)
      add :division_id, references(:divisions)
      add :home_team_id, references(:teams)
      add :fthg, :integer
      add :ftag, :integer
      add :ftr, :string
      add :hthg, :integer
      add :htag, :integer
      add :htr, :string
      add :away_team_id, references(:teams)
      timestamps()
    end
  end
end
