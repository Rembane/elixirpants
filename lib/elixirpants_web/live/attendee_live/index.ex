defmodule ElixirpantsWeb.AttendeeLive.Index do
  use ElixirpantsWeb, :live_view

  alias Elixirpants.Attendees
  alias Elixirpants.Attendees.Attendee

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :attendees, list_attendees())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Attendee")
    |> assign(:attendee, Attendees.get_attendee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Attendee")
    |> assign(:attendee, %Attendee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Attendees")
    |> assign(:attendee, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    attendee = Attendees.get_attendee!(id)
    {:ok, _} = Attendees.delete_attendee(attendee)

    {:noreply, assign(socket, :attendees, list_attendees())}
  end

  defp list_attendees do
    Attendees.list_attendees()
  end
end
