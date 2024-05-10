defmodule GoolifyWeb.AnimationLive.Show do
  use GoolifyWeb, :live_view

  alias Goolify.AnimationComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:animation, AnimationComponent.get_animation!(id))}
  end

  defp page_title(:show), do: "Show Animation"
  defp page_title(:edit), do: "Edit Animation"
end
