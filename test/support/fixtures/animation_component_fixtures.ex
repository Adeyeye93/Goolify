defmodule Goolify.AnimationComponentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Goolify.AnimationComponent` context.
  """

  @doc """
  Generate a animation.
  """
  def animation_fixture(attrs \\ %{}) do
    {:ok, animation} =
      attrs
      |> Enum.into(%{

      })
      |> Goolify.AnimationComponent.create_animation()

    animation
  end
end
