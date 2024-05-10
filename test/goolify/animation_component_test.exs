defmodule Goolify.AnimationComponentTest do
  use Goolify.DataCase

  alias Goolify.AnimationComponent

  describe "animation" do
    alias Goolify.AnimationComponent.Animation

    import Goolify.AnimationComponentFixtures

    @invalid_attrs %{}

    test "list_animation/0 returns all animation" do
      animation = animation_fixture()
      assert AnimationComponent.list_animation() == [animation]
    end

    test "get_animation!/1 returns the animation with given id" do
      animation = animation_fixture()
      assert AnimationComponent.get_animation!(animation.id) == animation
    end

    test "create_animation/1 with valid data creates a animation" do
      valid_attrs = %{}

      assert {:ok, %Animation{} = animation} = AnimationComponent.create_animation(valid_attrs)
    end

    test "create_animation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AnimationComponent.create_animation(@invalid_attrs)
    end

    test "update_animation/2 with valid data updates the animation" do
      animation = animation_fixture()
      update_attrs = %{}

      assert {:ok, %Animation{} = animation} = AnimationComponent.update_animation(animation, update_attrs)
    end

    test "update_animation/2 with invalid data returns error changeset" do
      animation = animation_fixture()
      assert {:error, %Ecto.Changeset{}} = AnimationComponent.update_animation(animation, @invalid_attrs)
      assert animation == AnimationComponent.get_animation!(animation.id)
    end

    test "delete_animation/1 deletes the animation" do
      animation = animation_fixture()
      assert {:ok, %Animation{}} = AnimationComponent.delete_animation(animation)
      assert_raise Ecto.NoResultsError, fn -> AnimationComponent.get_animation!(animation.id) end
    end

    test "change_animation/1 returns a animation changeset" do
      animation = animation_fixture()
      assert %Ecto.Changeset{} = AnimationComponent.change_animation(animation)
    end
  end
end
