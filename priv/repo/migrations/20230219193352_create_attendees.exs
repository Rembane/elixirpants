defmodule Elixirpants.Repo.Migrations.CreateAttendees do
  use Ecto.Migration

  def change do
    create table(:attendees) do
      add :cid, :string, null: false
      add :name, :string, null: false
      add :nick, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:attendees, [:cid])
  end
end
