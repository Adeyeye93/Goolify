defmodule GoolifyWeb.AnimationComponent do
   use Phoenix.Component


  def mount(_params, _session, socket) do
  {:ok, assign(socket, animation_data: "your_lottie_json_data"), temporary_assigns: [animation_data: true]}
end

def render(assigns) do
  ~H"""
  <div id="animationContainer">
  </div>
  """
end

end
