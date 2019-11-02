defmodule Timesheet.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :budget_hours, :integer
    field :description, :string
    field :job_code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:job_code, :budget_hours, :name, :description])
    |> validate_required([:job_code, :budget_hours, :name, :description])
  end
end
