defmodule GoolifyWeb.SecondFactorAuthLive do
  use GoolifyWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>2 Factor Authentication</h1>
    <button> <.link patch={~p"/user/settings/additional_security/security_questions"}>Security question</.link></button>
    <.link patch={~p"/user/settings/additional_security/security_passcode"}><button>Authenticator App</button></.link>


    <.modal :if={@live_action in [:security_questions, :pass_code]} id="product-modal" show on_cancel={JS.patch(~p"/user/settings/additional_security")}>
    <.live_component module={Goolify.Account.SecondFactorForm} id={@live_action }  />
    </.modal>
    """


  end


  def mount(_sessions, _param, socket) do
    {:ok, socket}
  end

  def handle_params(params, _urls, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :security_questions, _params) do
    socket
    |> assign(page_title: " Add security question")
  end

  defp apply_action(socket, :add_security, _params) do
    socket
    |> assign(page_title: " Add 2-Factor Authentication")
  end

  defp apply_action(socket, :pass_code, _params) do
    socket
    |> assign(page_title: " Setup Passcode")
  end





end
