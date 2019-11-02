defmodule Timesheet.Repo.Migrations.AddPassword do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :password_hash, :string, default: "", null: true
    end
  end
end
