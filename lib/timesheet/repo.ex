defmodule Timesheet.Repo do
  use Ecto.Repo,
    otp_app: :timesheet,
    adapter: Ecto.Adapters.Postgres
end
