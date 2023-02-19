defmodule ElixirpantsWeb.AttendeeLive.FormComponent do
  use ElixirpantsWeb, :live_component

  alias Elixirpants.Attendees

  @impl true
  def update(%{attendee: attendee} = assigns, socket) do
    changeset = Attendees.change_attendee(attendee)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"attendee" => attendee_params}, socket) do
    changeset =
      socket.assigns.attendee
      |> Attendees.change_attendee(attendee_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"attendee" => attendee_params}, socket) do
    save_attendee(socket, socket.assigns.action, attendee_params)
  end

  defp save_attendee(socket, :edit, attendee_params) do
    case Attendees.update_attendee(socket.assigns.attendee, attendee_params) do
      {:ok, _attendee} ->
        {:noreply,
         socket
         |> put_flash(:info, "Attendee updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_attendee(socket, :new, attendee_params) do
    case Attendees.create_attendee(attendee_params) do
      {:ok, _attendee} ->
        {:noreply,
         socket
         |> put_flash(:info, "Attendee created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
