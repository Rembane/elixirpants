defmodule Elixirpants.AttendeesTest do
  use Elixirpants.DataCase

  alias Elixirpants.Attendees

  describe "attendees" do
    alias Elixirpants.Attendees.Attendee

    import Elixirpants.AttendeesFixtures

    @invalid_attrs %{name: nil}

    test "list_attendees/0 returns all attendees" do
      attendee = attendee_fixture()
      assert Attendees.list_attendees() == [attendee]
    end

    test "get_attendee!/1 returns the attendee with given id" do
      attendee = attendee_fixture()
      assert Attendees.get_attendee!(attendee.id) == attendee
    end

    test "create_attendee/1 with valid data creates a attendee" do
      valid_attrs = %{name: "some name", cid: "somename333"}

      assert {:ok, %Attendee{} = attendee} = Attendees.create_attendee(valid_attrs)
      assert attendee.name == "some name"
    end

    test "create_attendee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendees.create_attendee(@invalid_attrs)
    end

    test "update_attendee/2 with valid data updates the attendee" do
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Attendee{} = attendee} = Attendees.update_attendee(attendee_fixture(), update_attrs)
      assert attendee.name == "some updated name"
    end

    test "update_attendee/2 with invalid data returns error changeset" do
      attendee = attendee_fixture()
      assert {:error, %Ecto.Changeset{}} = Attendees.update_attendee(attendee, @invalid_attrs)
      assert attendee == Attendees.get_attendee!(attendee.id)
    end

    test "delete_attendee/1 deletes the attendee" do
      attendee = attendee_fixture()
      assert {:ok, %Attendee{}} = Attendees.delete_attendee(attendee)
      assert_raise Ecto.NoResultsError, fn -> Attendees.get_attendee!(attendee.id) end
    end

    test "change_attendee/1 returns a attendee changeset" do
      attendee = attendee_fixture()
      assert %Ecto.Changeset{} = Attendees.change_attendee(attendee)
    end
  end
end
