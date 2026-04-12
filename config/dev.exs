import Config

config :chat, ChatWeb.Endpoint,

  http: [ip: {127, 0, 0, 1}],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "YhBv+9QSU+OtotrPQ3x4I+4xu6Og7ReEVHTsxIjtwVGLUY3G+3kwQBVskg1y5byO",
  watchers: []

config :logger, :default_formatter, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :chat, Chat.Repo,
  username: System.get_env("DB_USER"),
  passwword: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_NAME"),
  hostname: System.get_env("DB_HOST"),
  port: System.get_env("DB_PORT"),
  pool_size: 10
