defmodule ChatWeb.Router do
  use ChatWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ChatWeb do
    pipe_through :api

    get "/users/:user_id/rooms", RoomController, :get_rooms_by_user_id
  end

  scope "/api", ChatWeb do
    pipe_through :api

    get "/users/:user_id/:room_id/messages", RoomController, :get_messages_by_room_id
  end

end
