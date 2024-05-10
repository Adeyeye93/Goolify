defmodule GoolifyWeb.AnimationLive.Index do
  use GoolifyWeb, :live_view

  alias Goolify.AnimationComponent
  alias Goolify.AnimationComponent.Animation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :animation_collection, AnimationComponent.list_animation())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Animation")
    |> assign(:animation, AnimationComponent.get_animation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Animation")
    |> assign(:animation, %Animation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Animation")
    |> assign(:animation, nil)
  end

  @impl true
  def handle_info({GoolifyWeb.AnimationLive.FormComponent, {:saved, animation}}, socket) do
    {:noreply, stream_insert(socket, :animation_collection, animation)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    animation = AnimationComponent.get_animation!(id)
    {:ok, _} = AnimationComponent.delete_animation(animation)

    {:noreply, stream_delete(socket, :animation_collection, animation)}
  end
end
