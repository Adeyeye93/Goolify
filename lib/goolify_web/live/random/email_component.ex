defmodule Goolifyweb.Random.EmailComponent do
  use GoolifyWeb, :live_component

  def render(assigns) do
    ~H"""
      <h1>
      EMAIL VERIFICATION SENT
      </h1>
    """
  end
end
