import Config

IO.puts(System.get_env("DB_USER"))

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
  username: "chat_admin",
  password: "f3245454h5b34hvfgj325v23",
  database: "deve_chat",
  hostname: "localhost",
  port: 5433,
  pool_size: 10
