defmodule Chat.Repo.Migrations.CreateRoomsAndMessages do
  use Ecto.Migration

  def change do

    create table(:rooms, primary_key: false) do

      add :id, :uuid, primary_key: true
      add :room_name, :string, null: false
      add :owner_id, :uuid, null: false
      add :logo_url, :text, null: false
      add :accessability, :text, null: true # public/private ( only for groups )
      add :room_type, :text, null: false # group/channel/user
      timestamps()

    end

    create table(:room_users, primary_key: false) do

      add :id, :bigserial
      add :room_id, references(:rooms, type: :uuid, on_delete: :delete_all)
      add :user_id, :uuid, null: false
      add :user_name, :text, null: false
      timestamps()

    end

    create table(:messages, primary_key: false) do

      add :id, :bigserial
      add :room_id, references(:rooms, type: :uuid, on_delete: :delete_all), null: false
      add :user_id, :uuid, null: false
      add :user_name, :text, null: false
      add :body, :text, null: false
      timestamps()

    end

    create index(:messages, [:room_id])
    create index(:messages, [:inserted_at])

  end
end
