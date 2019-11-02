defmodule Timesheet.Repo.Migrations.AddManagerDetails do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :isManager, :boolean, default: false, null: false
      add :manager_id, references(:users), null: true
    end
  end
end
