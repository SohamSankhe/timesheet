defmodule TimesheetWeb.SheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Sheets
  alias Timesheet.Sheets.Sheet

  def index(conn, _params) do
    #sheets = Sheets.list_sheets()

    currentUser =  conn.assigns[:current_user]
    if nil != currentUser do
      if !currentUser.isManager do
        sheets = Sheets.get_sheets_by_user(currentUser.id)
        render(conn, "index.html", sheets: sheets)
      else
        sheets = Sheets.get_sheets_by_manager(currentUser.id)
        render(conn, "index.html", sheets: sheets)
      end
    else # keeping the original
      sheets = Sheets.list_sheets()
      render(conn, "index.html", sheets: sheets)
    end

    #sheets = Sheets.get_sheets_by_user()
    #render(conn, "index.html", sheets: sheets)
  end

  def new(conn, _params) do
    changeset = Sheets.change_sheet(%Sheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sheet" => sheet_params}) do
    sheet_params = setTasks(sheet_params)
    sheet_params = Map.put(sheet_params, "user_id", conn.assigns[:current_user].id)
    sheet_params = Map.put(sheet_params, "manager_id", conn.assigns[:current_user].manager_id)
    case Sheets.create_sheet(sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet created successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def setTasks(attrs) do
    taskList = [{"task1Name", "task1_id"}, {"task2Name", "task2_id"},
      {"task3Name", "task3_id"}, {"task4Name", "task4_id"},
      {"task5Name", "task5_id"}, {"task6Name", "task6_id"},
      {"task7Name", "task7_id"}, {"task8Name", "task8_id"} ]
    newAttrs = Enum.reduce(taskList, attrs, fn {task, id}, acc ->
      if (nil != attrs[task] and "" != attrs[task]) do
        task = Timesheet.Tasks.get_task_job_code!(attrs[task])
        if nil != task do
          acc = Map.put(acc, id, task.id)
        else
          acc
        end
      else
        acc
      end
    end)
    IO.puts("newAttrs")
    IO.inspect newAttrs
    newAttrs
  end

  #def setTask1(attrs) do
  #  jobCode1 = attrs["task1Name"]
  #  task = Timesheet.Tasks.get_task_job_code!(jobCode1)
  #  Map.put(attrs, "task1_id", task.id)
  #end

  def show(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    IO.puts("fetched sheet")
    IO.inspect sheet
    render(conn, "show.html", sheet: sheet)
  end

  def edit(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    sheet = loadTasks(sheet)
    changeset = Sheets.change_sheet(sheet)
    render(conn, "edit.html", sheet: sheet, changeset: changeset)
  end

  def loadTasks(sheet) do
    taskList = [{:task1Name, :task1_id}, {:task2Name, :task2_id},
      {:task3Name, :task3_id}, {:task4Name, :task4_id},
      {:task5Name, :task5_id}, {:task6Name, :task6_id},
      {:task7Name, :task7_id}, {:task8Name, :task8_id}]
    newSheet = Enum.reduce(taskList, sheet, fn {taskName, taskId}, acc ->
      if (nil != Map.get(sheet, taskId)) do
        task = Timesheet.Tasks.get_task!(Map.get(sheet, taskId))
        if nil != task do
          acc = Map.put(acc, taskName, task.job_code)
        else
          acc
        end
      else
        acc
      end
    end)
    newSheet
  end

  def update(conn, %{"id" => id, "sheet" => sheet_params}) do
    sheet = Sheets.get_sheet!(id)

    case Sheets.update_sheet(sheet, sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet updated successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sheet: sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    {:ok, _sheet} = Sheets.delete_sheet(sheet)

    conn
    |> put_flash(:info, "Sheet deleted successfully.")
    |> redirect(to: Routes.sheet_path(conn, :index))
  end
end
