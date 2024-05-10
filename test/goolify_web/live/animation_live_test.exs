defmodule GoolifyWeb.AnimationLiveTest do
  use GoolifyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Goolify.AnimationComponentFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_animation(_) do
    animation = animation_fixture()
    %{animation: animation}
  end

  describe "Index" do
    setup [:create_animation]

    test "lists all animation", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/animation")

      assert html =~ "Listing Animation"
    end

    test "saves new animation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/animation")

      assert index_live |> element("a", "New Animation") |> render_click() =~
               "New Animation"

      assert_patch(index_live, ~p"/animation/new")

      assert index_live
             |> form("#animation-form", animation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#animation-form", animation: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/animation")

      html = render(index_live)
      assert html =~ "Animation created successfully"
    end

    test "updates animation in listing", %{conn: conn, animation: animation} do
      {:ok, index_live, _html} = live(conn, ~p"/animation")

      assert index_live |> element("#animation-#{animation.id} a", "Edit") |> render_click() =~
               "Edit Animation"

      assert_patch(index_live, ~p"/animation/#{animation}/edit")

      assert index_live
             |> form("#animation-form", animation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#animation-form", animation: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/animation")

      html = render(index_live)
      assert html =~ "Animation updated successfully"
    end

    test "deletes animation in listing", %{conn: conn, animation: animation} do
      {:ok, index_live, _html} = live(conn, ~p"/animation")

      assert index_live |> element("#animation-#{animation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#animation-#{animation.id}")
    end
  end

  describe "Show" do
    setup [:create_animation]

    test "displays animation", %{conn: conn, animation: animation} do
      {:ok, _show_live, html} = live(conn, ~p"/animation/#{animation}")

      assert html =~ "Show Animation"
    end

    test "updates animation within modal", %{conn: conn, animation: animation} do
      {:ok, show_live, _html} = live(conn, ~p"/animation/#{animation}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Animation"

      assert_patch(show_live, ~p"/animation/#{animation}/show/edit")

      assert show_live
             |> form("#animation-form", animation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#animation-form", animation: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/animation/#{animation}")

      html = render(show_live)
      assert html =~ "Animation updated successfully"
    end
  end
end
