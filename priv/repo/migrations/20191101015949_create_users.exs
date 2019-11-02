defmodule Timesheet.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      #add :isManager, :boolean
      #add :manager_id, references(:users)
      timestamps()
    end

  end
end
