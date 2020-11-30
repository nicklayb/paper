defmodule PaperWeb.LiveComponent.Modal do
  use PaperWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def handle_event("close-modal", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.back_to)}
  end
end
