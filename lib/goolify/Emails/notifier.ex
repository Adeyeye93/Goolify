defmodule Goolify.Emails.Notifier do
  import Swoosh.Email

  alias Goolify.Mailer



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
  Deliver Sensitive information to users account.
  """
  def sensitive(user, :security_question) do
    deliver(user.email, "Confirmation instructions", """

    ==============================

    Hi #{user.email},

    You can confirm your account by visiting the URL below:


    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end
end
