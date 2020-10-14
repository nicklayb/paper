defmodule PaperWeb.UserView do
  use PaperWeb, :view
  alias Paper.User

  def full_name(user), do: User.full_name(user)
end
