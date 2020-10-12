defmodule PaperWeb.Layouts.View do
  use Phoenix.View, root: "lib/paper_web", path: "layouts/templates", namespace: PaperWeb
  use Phoenix.HTML

  import Phoenix.Controller, only: [get_flash: 2]

  alias PaperWeb.Router.Helpers, as: Routes
end
