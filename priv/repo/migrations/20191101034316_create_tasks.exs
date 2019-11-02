defmodule Timesheet.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :job_code, :string
      add :budget_hours, :integer
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end
