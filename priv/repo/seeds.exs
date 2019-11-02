# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheet.Repo.insert!(%Timesheet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Timesheet.Repo
alias Timesheet.Users.User
alias Timesheet.Tasks.Task

pw = Argon2.hash_pwd_salt("test")

alice = Repo.insert!(%User{name: "Alice Anderson", email: "alice@acme.com", isManager: true, password_hash: pw})
bob = Repo.insert!(%User{name: "Bob Anderson", email: "bob@acme.com", isManager: true, password_hash: pw})
Repo.insert!(%User{name: "Carol Anderson", email: "carol@acme.com", isManager: false, manager_id: alice.id, password_hash: pw})
Repo.insert!(%User{name: "Dave Anderson", email: "dave@acme.com", isManager: false, manager_id: bob.id, password_hash: pw})


Repo.insert!(%Task{job_code: "VAOR-01", budget_hours: 20, name: "Cyborg Arm", description: "1"})
Repo.insert!(%Task{job_code: "VAOR-02", budget_hours: 45, name: "Sobriety Pill", description: "1"})
Repo.insert!(%Task{job_code: "VAOR-03", budget_hours: 12, name: "Rat Cancer", description: "1"})
