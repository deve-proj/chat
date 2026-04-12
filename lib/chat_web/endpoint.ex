defmodule ChatWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :chat

  plug Corsica, origins: ["http://localhost:5173"], allow_credentials: true, allow_header: :all, max_age: 86400

  socket "/", ChatWeb.UserSocket,
  websocket: [
    path: "/socket/websocket",
    compress: true
  ],
  longpoll: false


  @session_options [
    store: :cookie,
    key: "_chat_key",
    signing_salt: "1H2wACX+",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]


  plug Plug.Static,
    at: "/",
    from: :chat,
    gzip: not code_reloading?,
    only: ~w(assets fonts images favicon.ico robots.txt chat_test.html),
    raise_on_missing_only: code_reloading?


  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug ChatWeb.Router
end
