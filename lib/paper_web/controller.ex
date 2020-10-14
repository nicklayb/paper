defmodule PaperWeb.Controller do
  defmacro __using__(_) do
    quote do
      def action(conn, _), do: PaperWeb.Controller.__action__(__MODULE__, conn)
      defoverridable action: 2
      import PaperWeb.Controller
    end
  end

  @doc """
    Put the current user as a third parameter in each actions on the controller
  """
  def __action__(controller, conn) do
    args = [conn, conn.params, conn.assigns[:current_user]]
    apply(controller, Phoenix.Controller.action_name(conn), args)
  end
end
