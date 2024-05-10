defmodule Goolify.AnimationComponent.Animation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animation" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(animation, attrs) do
    animation
    |> cast(attrs, [])
    |> validate_required([])
  end
end
