defmodule PaperWeb.Users.View do
  use PaperWeb, :view
  use Phoenix.View, root: "lib/paper_web", path: "users/templates", namespace: PaperWeb

  alias Paper.User

  def full_name(user), do: User.full_name(user)
end
