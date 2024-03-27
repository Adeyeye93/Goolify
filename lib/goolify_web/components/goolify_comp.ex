defmodule GoolifyWeb.GoolifyComp do
  @moduledoc """
  Goolify special components
  """

  use Phoenix.Component

  attr :ids, :list, default: [], doc: "button type"
  attr :type, :string, required: true, doc: "buttons behaviour"
  attr :class, :string, required: false, doc: "buttons design"
  slot :inner_block, required: true


  def goolifyButton(assigns) do
    ~H"""
    <div :for={id <- @ids}>
      <.display_button
        name={id.name}
        href={id.href}
        text={id.text}
        type={@type}
        class="w-40 bg-transparent hover:bg-slate-50 h-fit py-1 rounded-lg px-3 border-2 border-grey-500 font-bold font-black-100 font-primary flex flex-row items-center justify-center"
      >
        <%= {@text} %>
      </.display_button>
    </div>
    """
  end

  attr :name, :string, required: true, doc: "action name"
  attr :href, :string, required: true, doc: "action link"
  attr :type, :string, required: true, doc: "action type"
  attr :class, :string, required: true, doc: "action design"
  attr :text, :string, required: true, doc: "button text"
  slot :inner_block, required: true

  def display_button(%{name: "google-auth"} = assigns) do
    ~H"""
    <a href={@href}>
      <button type={@type} class={@class}>
      <svg xmlns="http://www.w3.org/2000/svg" class="mr-2" x="0px" y="0px" width="30" height="30" viewBox="0 0 48 48">
      <path fill="#fbc02d" d="M43.611,20.083H42V20H24v8h11.303c-1.649,4.657-6.08,8-11.303,8c-6.627,0-12-5.373-12-12	s5.373-12,12-12c3.059,0,5.842,1.154,7.961,3.039l5.657-5.657C34.046,6.053,29.268,4,24,4C12.955,4,4,12.955,4,24s8.955,20,20,20	s20-8.955,20-20C44,22.659,43.862,21.35,43.611,20.083z"></path><path fill="#e53935" d="M6.306,14.691l6.571,4.819C14.655,15.108,18.961,12,24,12c3.059,0,5.842,1.154,7.961,3.039	l5.657-5.657C34.046,6.053,29.268,4,24,4C16.318,4,9.656,8.337,6.306,14.691z"></path><path fill="#4caf50" d="M24,44c5.166,0,9.86-1.977,13.409-5.192l-6.19-5.238C29.211,35.091,26.715,36,24,36	c-5.202,0-9.619-3.317-11.283-7.946l-6.522,5.025C9.505,39.556,16.227,44,24,44z"></path><path fill="#1565c0" d="M43.611,20.083L43.595,20L42,20H24v8h11.303c-0.792,2.237-2.231,4.166-4.087,5.571	c0.001-0.001,0.002-0.001,0.003-0.002l6.19,5.238C36.971,39.205,44,34,44,24C44,22.659,43.862,21.35,43.611,20.083z"></path>
      </svg>
      <%= @text %></button>
    </a>
    """
  end

  def display_button(%{name: "linkedin-auth"} = assigns) do
    ~H"""
    <a href={@href}>
      <button type={@type} class={@class}>
      <svg xmlns="http://www.w3.org/2000/svg" class="mr-2" viewBox="0 0 48 48" width="30px" height="30px"><path fill="#0288D1" d="M42,37c0,2.762-2.238,5-5,5H11c-2.761,0-5-2.238-5-5V11c0-2.762,2.239-5,5-5h26c2.762,0,5,2.238,5,5V37z"/><path fill="#FFF" d="M12 19H17V36H12zM14.485 17h-.028C12.965 17 12 15.888 12 14.499 12 13.08 12.995 12 14.514 12c1.521 0 2.458 1.08 2.486 2.499C17 15.887 16.035 17 14.485 17zM36 36h-5v-9.099c0-2.198-1.225-3.698-3.192-3.698-1.501 0-2.313 1.012-2.707 1.99C24.957 25.543 25 26.511 25 27v9h-5V19h5v2.616C25.721 20.5 26.85 19 29.738 19c3.578 0 6.261 2.25 6.261 7.274L36 36 36 36z"/></svg>
      <%= @text %></button>
    </a>
    """
  end
end
