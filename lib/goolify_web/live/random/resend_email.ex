defmodule GoolifyWeb.Random.ResendEmail do
  use GoolifyWeb, :live_view
  use GoolifyWeb, :static_paths
  alias Goolify.Account


def render(assigns) do
  ~H"""

  <div class="w-ful h-screen flex flex-col justify-between items-center bg-slate-50">
    <div class="w-full min-h-16 h-16 border-b-2 border-y-fuchsia-500 bg-slate-200"></div>
      <div class="w-full h-full border-2 flex justify-center items-center">
        <div class="w-2/5  border-slate-300 border border-solid h-4/5 bg-white rounded-xl flex flex-col justify-between items-center px-20">
        <img src={static_path(@socket, "/images/sent1.gif")} class=" w-50 h-50"/>
        <p class="font-primary text-center font-medium text-slate-600">We have sent a verification link to <span class="font-semibold"><%= assigns.current_user.email %></span>, please open your email to verify your account</p>
        <div class="flex h-60 w-full flex flex-col justify-evenly ">
        <div class="w-full flex items-center justify-evenly">
           <hr class="border-t-1 border-grey-200 w-1/5"/>
              <small class="font-normal text-zinc-300 font-secondary">Didn't receive email?</small>
            <hr class="border-t-1 border-gray-200 w-1/5" />
        </div>
        <div class="w-full h-30 flex flex-row justify-evenly items-center">
            <button id="resend" class="bg-fuchsia-500 w-2/5 text-slate-100 font-primary text-center font-normal h-10 rounded-lg border border-solid disabled:bg-slate-200 disabled:text-slate-400" type="button" phx-click="resend" phx-click-away={
             JS.set_attribute({"disabled", ""}) } disabled>resend</button>

            <div id="counter" class="bg-slate-50 w-2/5 flex flex-row justify-center items-center text-gray-900 font-primary text-center font-normal h-10 rounded-lg border border-solid"> <%= @seconds %>sec</div>
        </div>

        </div>
        </div>
    </div>
  </div>

  """
end

def mount(_params, _session, socket) do

  if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, assign(socket, page_title: "Email verification sent", seconds: 50)}

end

def handle_event("resend",  _params, socket) do
    user = socket.assigns.current_user

    case Account.deliver_user_confirmation_instructions(user, &url(~p"/users/confirm/#{&1}")) do
      {:ok, _} ->
        socket =
        socket
        |> assign(seconds: 50)
        |> put_flash(:info, "Email has been resent successfully")
        {:noreply, socket}
      {:error, _why?} ->
        socket =
        socket
        |> put_flash(:error, "Email was not sent, Please resend again in few seconds")
        {:noreply, socket}

    end

  end

  def handle_info(:tick, socket) do
    case socket.assigns.seconds do
      0 ->
        {:noreply, assign(socket, seconds: 0) |> push_event("enable_resend", %{id: "resend"})}

      _ ->
         {:noreply, assign(socket, seconds: socket.assigns.seconds - 1)}
    end

  end

end
