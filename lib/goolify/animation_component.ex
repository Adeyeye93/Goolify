defmodule Goolify.AnimationComponent do
  @moduledoc """
  The AnimationComponent context.
  """

  import Ecto.Query, warn: false
  alias Goolify.Repo

  alias Goolify.AnimationComponent.Animation

  @doc """
  Returns the list of animation.

  ## Examples

      iex> list_animation()
      [%Animation{}, ...]

  """
  def list_animation do
    Repo.all(Animation)
  end

  @doc """
  Gets a single animation.

  Raises `Ecto.NoResultsError` if the Animation does not exist.

  ## Examples

      iex> get_animation!(123)
      %Animation{}

      iex> get_animation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_animation!(id), do: Repo.get!(Animation, id)

  @doc """
  Creates a animation.

  ## Examples

      iex> create_animation(%{field: value})
      {:ok, %Animation{}}

      iex> create_animation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_animation(attrs \\ %{}) do
    %Animation{}
    |> Animation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a animation.

  ## Examples

      iex> update_animation(animation, %{field: new_value})
      {:ok, %Animation{}}

      iex> update_animation(animation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_animation(%Animation{} = animation, attrs) do
    animation
    |> Animation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a animation.

  ## Examples

      iex> delete_animation(animation)
      {:ok, %Animation{}}

      iex> delete_animation(animation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_animation(%Animation{} = animation) do
    Repo.delete(animation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking animation changes.

  ## Examples

      iex> change_animation(animation)
      %Ecto.Changeset{data: %Animation{}}

  """
  def change_animation(%Animation{} = animation, attrs \\ %{}) do
    Animation.changeset(animation, attrs)
  end
end
