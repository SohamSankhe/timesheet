defmodule TimesheetWeb.PageController do
  use TimesheetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
