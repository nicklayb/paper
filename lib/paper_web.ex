defmodule PaperWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: PaperWeb
      use PaperWeb.Controller

      import Plug.Conn
      import PaperWeb.Gettext
      alias PaperWeb.Router.Helpers, as: Routes
      import Phoenix.LiveView.Controller
    end
  end

  def view do
    quote do
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {PaperWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import PaperWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      use Phoenix.HTML
      import Phoenix.LiveView.Helpers
      import PaperWeb.Live.Helpers
      import Phoenix.View
      import PaperWeb.ErrorHelpers
      import PaperWeb.FormHelpers
      import PaperWeb.Gettext
      alias PaperWeb.Router.Helpers, as: Routes
      import PaperWeb.Shared
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
