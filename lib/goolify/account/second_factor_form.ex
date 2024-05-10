defmodule Goolify.Account.SecondFactorForm do
  use GoolifyWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
      <h1>SecondFactor authentication</h1>
    """
  end
end
