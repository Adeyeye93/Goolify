defmodule Goolify.Account.SecondFactor do
  use Ecto.Schema
  import Ecto.Changeset
  import Goolify.Account.User


  schema "second_factor" do
    field :authentication_type, :string
    field :auth_code, :string, virtual: true, redact: true


    timestamps(type: :utc_datetime)

  end


  def security_question_changeset(user, attr, opt \\ []) do
    user
    |> cast(attr, [:authentication_type, :auth_code])
    |> maybe_hash_password(opt)
  end


end
