defmodule GoolifyWeb.UserRegistrationLive do
  use GoolifyWeb, :live_view
  use GoolifyWeb, :static_paths
  alias Goolify.Account
  alias Goolify.Account.User
  import GoolifyWeb.GoolifyComp

  def render(assigns) do
    ~H"""
    <div class="w-full h-screen flex flex-row">
      <div class="w-1/2 h-full flex justify-center items-center">
        <div class="w-3/5 h-4/5">
          <.header class="text-left">
            <h1 class="font-bold text-3xl font-primary">Sign-up</h1>
            <%!-- <:subtitle>
            Already registered?

            to your account now.
          </:subtitle> --%>
          </.header>

          <.simple_form
            for={@form}
            id="registration_form"
            phx-submit="save"
            phx-change="validate"
            phx-trigger-action={@trigger_submit}
            action={~p"/users/log_in?_action=registered"}
            method="post"
          >
            <.error :if={@check_errors}>
              Oops, something went wrong! Please check the errors below.
            </.error>

            <.input field={@form[:username]} placeholder="Your username" type="text" required />
            <.input field={@form[:email]} placeholder="Your Email" type="email" required />
            <.input field={@form[:password]} type="password" placeholder="Password" required />

            <:actions>
              <.button
                phx-disable-with="Creating account..."
                class="w-full bg-brand hover:bg-brand-400 font-primary"
              >
                Create an account
              </.button>
              <.link
                navigate={~p"/users/reset_password"}
                class="font-semibold self-end text-brand font-primary"
              >
                Forgot password?
              </.link>
            </:actions>
          </.simple_form>
          <br />
          <div class="w-full h-32  flex flex-col items-center justify-between">
            <div class="flex flex-row items-center w-full justify-between">
              <hr class="border-t-2 border-grey-200 w-2/5" />
              <p class="font-bold text-zinc-400 font-primary">or</p>
              <hr class="border-t-2 border-gray-200 w-2/5" />
            </div>
            <div class="w-full flex justify-evenly items-center flex-row">
              <.goolifyButton
                ids={[
                  %{name: "google-auth", href: "#", text: "Google"},
                  %{name: "linkedin-auth", href: "#", text: "Linkedin"}
                ]}
                type="button"
              >
              </.goolifyButton>
              <%!-- <.goolifyButton ids={[%{name: "linkedin-auth", href: "#"}]} type="button">
                Linkedin
              </.goolifyButton> --%>
            </div>
            <div class="w-full text-gray-400 font-normal self-start font-primary">
              Already have an account?
              <.link navigate={~p"/users/log_in"} class="font-normal text-brand font-secondary">
                Sign in
              </.link>
            </div>
          </div>
        </div>
      </div>
      <div class="w-1/2 h-full relative">
        <div class="absolute h-20 inset-x-0 top-0 w-full flex justify-between items-center">


        </div>
        <img src={static_path(@socket, "/images/auth-img.svg")} class="object-cover w-full h-full"/>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Account.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Account.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} = Account.deliver_user_confirmation_instructions(user, &url(~p"/users/confirm/#{&1}"))

        changeset = Account.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Account.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
