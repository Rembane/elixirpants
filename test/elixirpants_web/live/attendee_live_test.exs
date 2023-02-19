defmodule ElixirpantsWeb.AttendeeLiveTest do
  use ElixirpantsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Elixirpants.AttendeesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_attendee(_) do
    attendee = attendee_fixture()
    %{attendee: attendee}
  end

  describe "Index" do
    setup [:create_attendee]

    test "lists all attendees", %{conn: conn, attendee: attendee} do
      {:ok, _index_live, html} = live(conn, Routes.attendee_index_path(conn, :index))

      assert html =~ "Listing Attendees"
      assert html =~ attendee.name
    end

    test "saves new attendee", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.attendee_index_path(conn, :index))

      assert index_live |> element("a", "New Attendee") |> render_click() =~
               "New Attendee"

      assert_patch(index_live, Routes.attendee_index_path(conn, :new))

      assert index_live
             |> form("#attendee-form", attendee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#attendee-form", attendee: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.attendee_index_path(conn, :index))

      assert html =~ "Attendee created successfully"
      assert html =~ "some name"
    end

    test "updates attendee in listing", %{conn: conn, attendee: attendee} do
      {:ok, index_live, _html} = live(conn, Routes.attendee_index_path(conn, :index))

      assert index_live |> element("#attendee-#{attendee.id} a", "Edit") |> render_click() =~
               "Edit Attendee"

      assert_patch(index_live, Routes.attendee_index_path(conn, :edit, attendee))

      assert index_live
             |> form("#attendee-form", attendee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#attendee-form", attendee: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.attendee_index_path(conn, :index))

      assert html =~ "Attendee updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes attendee in listing", %{conn: conn, attendee: attendee} do
      {:ok, index_live, _html} = live(conn, Routes.attendee_index_path(conn, :index))

      assert index_live |> element("#attendee-#{attendee.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#attendee-#{attendee.id}")
    end
  end

  describe "Show" do
    setup [:create_attendee]

    test "displays attendee", %{conn: conn, attendee: attendee} do
      {:ok, _show_live, html} = live(conn, Routes.attendee_show_path(conn, :show, attendee))

      assert html =~ "Show Attendee"
      assert html =~ attendee.name
    end

    test "updates attendee within modal", %{conn: conn, attendee: attendee} do
      {:ok, show_live, _html} = live(conn, Routes.attendee_show_path(conn, :show, attendee))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Attendee"

      assert_patch(show_live, Routes.attendee_show_path(conn, :edit, attendee))

      assert show_live
             |> form("#attendee-form", attendee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#attendee-form", attendee: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.attendee_show_path(conn, :show, attendee))

      assert html =~ "Attendee updated successfully"
      assert html =~ "some updated name"
    end
  end
end
