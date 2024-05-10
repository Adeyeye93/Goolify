defmodule Goolify.Account.UserNotifier do
  import Swoosh.Email

  alias Goolify.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"Zify", "adeyeyeseyi2@gmail.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email, access_token: "ya29.a0AXooCgtTnPwMdm73zcIv1lCyFvHtpx0iN8ql1q-BhHdrx179ADQ7dMSRQ3QrSuI0ROU-sgQr0N0rSbjZkWnQqWW8qp9qHMBAniqRJTEaTtorkv16BvFJsNaAwuDUmIGY33M4aRia02RarWUg8zo-vsk3OlkPfrWgo1qPaCgYKAa0SARMSFQHGX2MiMjW8heMhpGe9L59XQ5JQcg0171"
) do
      {:ok, email}
    end


  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(user, url) do
    deliver(user.email, "Confirmation instructions", """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a user password.
  """
  def deliver_reset_password_instructions(user, url) do
    deliver(user.email, "Reset password instructions", """

    ==============================

    Hi #{user.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_update_email_instructions(user, url) do
    deliver(user.email, "Update email instructions", """

    ==============================

    Hi #{user.email},

    You can change your email by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end
end
