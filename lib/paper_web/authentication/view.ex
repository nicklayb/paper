defmodule PaperWeb.Authentication.View do
  use Phoenix.View, root: "lib/paper_web", path: "authentication/templates", namespace: PaperWeb
  use Phoenix.HTML
  alias PaperWeb.Router.Helpers, as: Routes
end
