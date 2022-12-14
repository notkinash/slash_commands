import Config

config :slash_commands,
  api_version: 10

  import_config "#{config_env()}.exs"
