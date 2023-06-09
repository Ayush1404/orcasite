defmodule Orcasite.Repo.Migrations.AddLastNotifiedAtToSubscriptions do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:subscriptions) do
      add :last_notified_at, :utc_datetime_usec

      add :last_notification_id,
          references(:notifications,
            column: :id,
            name: "subscriptions_last_notification_id_fkey",
            type: :uuid
          )
    end

    create index(:subscriptions, [:last_notified_at])
  end

  def down do
    drop constraint(:subscriptions, "subscriptions_last_notification_id_fkey")
    drop index(:subscriptions, [:last_notified_at])

    alter table(:subscriptions) do
      remove :last_notification_id
      remove :last_notified_at
    end
  end
end
