import Config

config :logger, level: :info

config :chat, Chat.Repo,
  username: System.get_env("DB_USER"),
  passwword: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_NAME"),
  hostname: System.get_env("DB_HOST"),
  port: System.get_env("DB_PORT"),
  pool_size: 10
