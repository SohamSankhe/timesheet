defmodule Timesheet.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    #add :isManager, :boolean
    #add :manager_id, references(:users)

    field :isManager, :boolean
    belongs_to :manager, Timesheet.Users.User

    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :isManager, :manager_id])
    |> hash_password()
    |> validate_required([:name, :email])
  end

  def hash_password(cset) do
    pw = get_change(cset, :password)
    if pw do
      change(cset, Argon2.add_hash(pw))
    else
      cset
    end
  end

end
