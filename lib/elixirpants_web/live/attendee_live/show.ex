defmodule ElixirpantsWeb.AttendeeLive.Show do
  use ElixirpantsWeb, :live_view

  alias Elixirpants.Attendees

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:attendee, Attendees.get_attendee!(id))}
  end

  defp page_title(:show), do: "Show Attendee"
  defp page_title(:edit), do: "Edit Attendee"
end
