defmodule SlashCommands.MixProject do
  use Mix.Project

  @source_url "https://github.com/notkinash/slash_commands"

  def project do
    [
      app: :slash_commands,
      version: "0.1.0",
      elixir: "~> 1.14",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "SlashCommands",
      source_url: @source_url
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      # Dev Tools
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29.1", only: :dev, runtime: false},

      # HTTP Client
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.18"},
      {:jason, "~> 1.4"}
    ]
  end

  defp description do
    "Discord Slash Commands for Elixir"
  end

  defp package do
    [
      name: "slash_commands",
      files: ~w(lib .formatter.exs .credo.exs mix.exs README* LICENSE*),
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
