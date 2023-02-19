defmodule Elixirpants.AttendeesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Elixirpants.Attendees` context.
  """

  @doc """
  Generate an attendee.
  """
  def attendee_fixture(attrs \\ %{}) do
    {:ok, attendee} =
      attrs
      |> Enum.into(%{
        cid: "somename12",
        name: "some name" ,
        nick: nil
      })
      |> Elixirpants.Attendees.create_attendee()

    attendee
  end
end
