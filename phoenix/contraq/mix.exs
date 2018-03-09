defmodule Contraq.Mixfile do
  use Mix.Project

  def project do
    [
      app: :contraq,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      preferred_cli_env: [espec: :test, "white_bread.run": :test],
      dialyzer: [
        flags: [:underspecs],
        ignore_warnings: "dialyzer.ignore-warnings",
        plt_add_deps: :transitive
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Contraq.Application, []},
      extra_applications: [:logger, :runtime_tools, :coherence]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.13.1"}, # see https://github.com/smpallen99/coherence/issues/329
      {:cowboy, "~> 1.0"},
      {:bcrypt_elixir, "~> 1.0"}, # see https://github.com/riverrun/comeonin/issues/106
      {:coherence, "~> 0.5"},
      {:dialyxir, "~> 0.5.0", only: [:dev], runtime: false},
      {:espec_phoenix, "~> 0.6.9", only: :test},
      {:ex_cell, "~> 0.0.11"},
      {:font_awesome_phoenix, "~> 0.1"},
      {:faker, "~> 0.9", [only: :test]},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false, github: "ignota/mix-test.watch", ref: "8ee5c331059e821830a325cd59e87821b3434f88"}, # TODO: waiting for https://github.com/lpil/mix-test.watch/pull/85
      {:phoenix_haml, "~> 0.2"},
      {:timex, "~> 3.0"},
      {:wallaby, "~> 0.19.2", [runtime: false, only: :test]},
      {:white_bread, only: [:dev, :test], github: "marnen/white-bread", ref: "4289bb8b5ad9fc3fd4dcffd6d4737a02a69c5615"} # TODO: waiting for https://github.com/meadsteve/white-bread/pull/96
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
