defmodule ChatWeb.Router do
  use ChatWeb, :router

  pipeline :api do
    plug :accepts, ["html"]
  end

  scope "/api", ChatWeb do
    pipe_through :api

    get "/test", TestController, :test

  end


end
