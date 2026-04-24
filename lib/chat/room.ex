defmodule Chat.Room do
  use GenServer

  def start_link(room_name, owner_id, logo_url, accessability, room_type, room_id \\ nil) do

    case room_id do

      nil ->

        IO.puts("Создаём новую комнату...")

        case Chat.create_room(%{
          room_name: room_name,
          owner_id: owner_id,
          logo_url: logo_url ||  "http://localhost:9000/default.png",
          room_type: room_type,
          accessability: accessability
        }) do

          {:ok, db_room} ->

            {:ok, pid} = GenServer.start_link(__MODULE__, [db_room.id, room_name], name: via_tuple(db_room.id))

            {:ok, pid, %{id: db_room.id, name: db_room.room_name, logo_url: db_room.logo_url}}

          {:error, changeset} ->

            {:error, changeset}

        end

      id ->

        start_server(id, room_name)

    end
  end

  def start_server(room_id, room_name) do

    case GenServer.start_link(__MODULE__, [room_id, room_name], name: via_tuple((room_id))) do

      {:ok, pid} -> {:ok, pid, room_id}
      error -> error

    end

  end


  @spec join(any(), any()) :: any()
  def join(room_id, user) do

    GenServer.call(via_tuple(room_id), {:join, user})

  end


  def leave(room_id, user) do

    GenServer.cast(via_tuple(room_id), {:leave, user})

  end


  def send_message(room_id, user_id, user_name, message) do

    GenServer.cast(via_tuple(room_id), {:send_message, user_id, user_name, message})

  end


  def get_users(room_id) do

    GenServer.call(via_tuple(room_id), :get_users)

  end

  def init([room_id, room_name]) do

    users = Enum.map(Chat.get_users_by_room_id(room_id), fn u -> %{id: u.user_id, name: u.user_name} end)

    IO.inspect(users)

    {:ok, %{room_id: room_id, room_name: room_name, users: users, messages: []}}

  end


  def handle_call({:join, user}, _from, state) do

      if user in state.users do
        IO.puts("Already exist, skip...")
        {:reply, {:ok, state.users}, state}

      else

        case Chat.join_room(%{
          room_id: state.room_id,
          user_id: user.id,
          user_name: user.name
        }) do

          {:ok, _db_user} ->
            new_state = %{state | users: [user | state.users]}
            {:reply, {:ok, new_state.users}, new_state}

          {:error, changeset} ->
            {:error, changeset}

        end

      end

  end

  def handle_call(:get_users, _from, state) do

    {:reply, {:ok, state.users}, state}

  end

  def handle_cast({:leave, user}, state) do

    new_state = %{state | users: List.delete(state.users, user)}

    {:noreply, new_state}

  end

  def handle_cast({:send_message, user_id, user_name, message}, state) do

    case Chat.new_message(%{
      room_id: state.room_id,
      user_id: user_id,
      user_name: user_name,
      body: message
    }) do

      {:ok, _db_message} ->

        new_message = %{user_id: user_id, user_name: user_name, message: message, timestamp: DateTime.utc_now()}
        new_state = %{state | messages: [new_message | state.messages]}

        {:noreply, new_state}

      {:error, _changeset} ->
        IO.puts("Failed to save message to database")
        {:noreply, state}


    end

  end

  def handle_call({:get_rooms_by_user_id, user_id}, state) do

    if user_id not in state.users do

      {:reply, {:error, "user not found"}}

    else

      {:reply, {:ok, }}

    end

  end

  def via_tuple(room_id) do

    {:via, Registry, {Chat.RoomRegistry, {:room, room_id}}}

  end

end
