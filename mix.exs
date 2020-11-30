defmodule Paper.MixProject do
  use Mix.Project

  def project do
    [
      app: :paper,
      version: "0.0.1",
      elixir: "~> 1.10",
      erlang: "~> 22.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  def application do
    [
      mod: {Paper.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  # Specifies your project dependencies.
  defp deps do
    [
      # HTTP server
      {:plug_cowboy, "~> 2.0"},

      # Phoenix
      {:phoenix, "~> 1.5.5"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:jason, "~> 1.0"},
      {:phoenix_live_view, "~> 0.15.0"},

      # Authentication
      {:ueberauth, "~> 0.6.3"},
      {:ueberauth_google, "~> 0.9.0"},
      {:guardian, "~> 2.1"},

      # Database
      {:postgrex, ">= 0.0.0"},
      {:ecto_sql, "~> 3.4"},

      # Translations
      {:gettext, "~> 0.11"},

      # Test factories
      {:ex_machina, "~> 2.3", only: :test},
      {:faker, "~> 0.12", only: :test}
    ]
  end
end
