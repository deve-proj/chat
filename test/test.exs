import Dotenvy
source!([".env"])

IO.puts("ENV data: " <> (System.get_env("S3_ACCESS_KEY") || "NOT SET"))
