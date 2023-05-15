# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :inventory,
  ecto_repos: [Inventory.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :inventory, InventoryWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: InventoryWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Inventory.PubSub,
  live_view: [signing_salt: "JJbTwPmT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config hooks for git
config :git_hooks,
  auto_install: true,
  hooks: [
    pre_commit: [
      verbose: true,
      tasks: [
        {:file, "./hooks/mix_format"}
      ]
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
