defmodule GoolifyWeb.AnimationLive.FormComponent do
  use GoolifyWeb, :live_component

  alias Goolify.AnimationComponent

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage animation records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="animation-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Animation</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{animation: animation} = assigns, socket) do
    changeset = AnimationComponent.change_animation(animation)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"animation" => animation_params}, socket) do
    changeset =
      socket.assigns.animation
      |> AnimationComponent.change_animation(animation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"animation" => animation_params}, socket) do
    save_animation(socket, socket.assigns.action, animation_params)
  end

  defp save_animation(socket, :edit, animation_params) do
    case AnimationComponent.update_animation(socket.assigns.animation, animation_params) do
      {:ok, animation} ->
        notify_parent({:saved, animation})

        {:noreply,
         socket
         |> put_flash(:info, "Animation updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_animation(socket, :new, animation_params) do
    case AnimationComponent.create_animation(animation_params) do
      {:ok, animation} ->
        notify_parent({:saved, animation})

        {:noreply,
         socket
         |> put_flash(:info, "Animation created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
