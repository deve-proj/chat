import Dotenvy
source!([".env"])

IO.puts("ENV data: " <> (System.get_env("MINIO_ACCESS_KEY") || "NOT SET"))
