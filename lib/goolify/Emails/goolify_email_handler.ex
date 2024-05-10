defmodule Goolify.GoolifyEmailHandler do

  import Goolify.Emails.Notifier

  def email_mapper(user, params, mapper) do
    handlers(user, params, mapper)
  end


  defp handlers(user, _param, :security_question) do
    sensitive(user, :security_question)
  end

end
