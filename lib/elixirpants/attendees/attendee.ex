defmodule Elixirpants.Attendees.Attendee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attendees" do
    field :cid, :string
    field :name, :string
    field :nick, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(attendee, attrs), do:
    cast(attendee, attrs, [:cid, :name, :nick]) |> validate_required([:cid, :name])
end
