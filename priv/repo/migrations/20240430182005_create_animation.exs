defmodule Goolify.Repo.Migrations.CreateAnimation do
  use Ecto.Migration

  def change do
    create table(:animation) do

      timestamps(type: :utc_datetime)
    end
  end
end
