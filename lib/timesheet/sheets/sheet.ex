defmodule Timesheet.Sheets.Sheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sheets" do
    field :date, :date

    field :hours1, :integer
    field :hours2, :integer
    field :hours3, :integer
    field :hours4, :integer
    field :hours5, :integer
    field :hours6, :integer
    field :hours7, :integer
    field :hours8, :integer

    field :is_approved, :boolean, default: false

    field :task1Name, :string, virtual: true
    field :task2Name, :string, virtual: true
    field :task3Name, :string, virtual: true
    field :task4Name, :string, virtual: true
    field :task5Name, :string, virtual: true
    field :task6Name, :string, virtual: true
    field :task7Name, :string, virtual: true
    field :task8Name, :string, virtual: true

    belongs_to :task1, Timesheet.Tasks.Task
    belongs_to :task2, Timesheet.Tasks.Task
    belongs_to :task3, Timesheet.Tasks.Task
    belongs_to :task4, Timesheet.Tasks.Task
    belongs_to :task5, Timesheet.Tasks.Task
    belongs_to :task6, Timesheet.Tasks.Task
    belongs_to :task7, Timesheet.Tasks.Task
    belongs_to :task8, Timesheet.Tasks.Task

    #field :manager_id, :id
    belongs_to :manager, Timesheet.Users.User

    #field :user_id, :id
    belongs_to :user, Timesheet.Users.User

    timestamps()
  end

  @doc false
  def changeset(sheet, attrs) do
    sheet
    |> cast(attrs, [:date, :hours1, :hours2, :hours3, :hours4, :hours5, :hours6, :hours7, :hours8, :is_approved,
      :task1_id, :task2_id, :task3_id, :task4_id, :task5_id, :task6_id, :task7_id, :task8_id, :user_id, :manager_id])
    |> validate_required([:date, :is_approved, :user_id, :manager_id])
    |> validate_max_hours([:hours1, :hours2, :hours3, :hours4, :hours5, :hours6, :hours7, :hours8])
  end


  def validate_max_hours(changeSet, fields) do

    totalHrs = cond do
      nil == changeSet.changes -> 0
      true ->
        Enum.reduce(fields, 0, fn field, acc ->
          if nil != Map.get(changeSet.changes, field) do
            acc = acc + Map.get(changeSet.changes, field)
          else
            acc
          end
        end)
    end

    # Ref: https://hexdocs.pm/ecto/Ecto.Changeset.html#validate_change/3
    if totalHrs > 8 do
      changeSet = Ecto.Changeset.validate_change(changeSet, :date , fn :date, totalHrs ->
        if totalHrs < 8 do
          []
        else
          [date: "Total hours worked cannot be > 8"]
        end
      end)
    else
      changeSet
    end  
  end
end
