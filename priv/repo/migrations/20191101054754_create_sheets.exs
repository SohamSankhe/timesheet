defmodule Timesheet.Repo.Migrations.CreateSheets do
  use Ecto.Migration

  def change do
    create table(:sheets) do
      add :date, :date
      add :hours1, :integer
      add :hours2, :integer
      add :hours3, :integer
      add :hours4, :integer
      add :hours5, :integer
      add :hours6, :integer
      add :hours7, :integer
      add :hours8, :integer
      add :is_approved, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :task1_id, references(:tasks, on_delete: :nothing)
      add :task2_id, references(:tasks, on_delete: :nothing)
      add :task3_id, references(:tasks, on_delete: :nothing)
      add :task4_id, references(:tasks, on_delete: :nothing)
      add :task5_id, references(:tasks, on_delete: :nothing)
      add :task6_id, references(:tasks, on_delete: :nothing)
      add :task7_id, references(:tasks, on_delete: :nothing)
      add :task8_id, references(:tasks, on_delete: :nothing)
      add :manager_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:sheets, [:user_id])
    create index(:sheets, [:task1_id])
    create index(:sheets, [:task2_id])
    create index(:sheets, [:task3_id])
    create index(:sheets, [:task4_id])
    create index(:sheets, [:task5_id])
    create index(:sheets, [:task6_id])
    create index(:sheets, [:task7_id])
    create index(:sheets, [:task8_id])
    create index(:sheets, [:manager_id])
  end
end
