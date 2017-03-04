defmodule WebDriver.Mixfile do
  use Mix.Project

  def project do
    [ app: :webdriver,
      version: "0.9.0",
      description: "Webdriver protocol for driving web browsers.",
      source_url: "https://github.com/stuart/elixir-webdriver",
      homepage_url: "http://stuart.github.io/elixir-webdriver",
      package: package(),
      deps: deps(),
      docs: [
        readme: true,
        main: "README"
      ]
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { WebDriver, []},
      registered:   [ :webdriver ],
      applications: [ :httpoison, :poison ],
      env: [ debug_browser: false ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:httpoison, "~> 0.11.0"},
      {:poison,    "~> 3.1"},
      {:mock,      github: "jjh42/mock", only: :test},
      {:earmark,   "~>1.1", only: :dev},
      {:apex,      "~>1.0.0", only: :test},
      {:ex_doc,    "~>0.15", only: :dev}
     ]
  end

  defp package do
    [
      contributors: ["Stuart Coyle", "Carl Woodward"],
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/stuart/elixir-webdriver",
               "Docs" => "http://stuart.github.io/elixir-webdriver/"}
    ]
  end
end
