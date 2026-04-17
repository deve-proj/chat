import Config
import Dotenvy

if System.get_env("PHX_SERVER") do
  config :chat, ChatWeb.Endpoint, server: true
end

config :chat, ChatWeb.Endpoint, http: [port: String.to_integer(System.get_env("PORT", "4000"))]

source!([
  ".env",
  ".#{config_env()}.env",
  System.get_env()
])

config :ex_aws,
  access_key_id: env!("MINIO_ACCESS_KEY"),
  secret_access_key: env!("MINIO_SECRET_KEY"),
  region: "us-east-1"

config :ex_aws, :s3,
  scheme: env!("MINIO_SCHEME"),
  host: env!("MINIO_HOST"),
  port: env!("MINIO_PORT")

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise "environment variable SECRET_KEY_BASE is missing"

  host = System.get_env("PHX_HOST") || "localhost"

  config :chat, ChatWeb.Endpoint,
    url: [host: host, port: 4000],
    secret_key_base: secret_key_base
end
