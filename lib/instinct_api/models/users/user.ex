defmodule InstinctApi.Models.Users.User do
  alias InstinctApi.Models.Users.{UserApplication, UserResume, UserWorkExperience, UserEducation}
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :accept_terms, :boolean, default: false
    field :active, :boolean, default: true
    field :email, :string
    field :fullname, :string
    field :password_hash, :string
    field :phone, :string
    field :role, :string, default: "seeker"

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_one :user_resume, UserResume
    has_many :user_work_experiences, UserWorkExperience
    has_many :user_educations, UserEducation
    has_many :user_applications, UserApplication

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation, :role, :fullname, :phone, :accept_terms])
    |> validate_required([:email, :password, :password_confirmation, :fullname, :phone, :accept_terms], message: "is required")
    |> validate_accept_terms(:accept_terms)
    |> update_change(:email, &String.downcase(&1))
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i, message: "invalid")
    |> unique_constraint(:email, name: :users_unique_email_index, message: "already registered")
    |> validate_email_unique(:email)
    |> unique_constraint(:phone, name: :users_unique_phone_index, message: "already registered")
    |> validate_length(:password, min: 6, max: 20, message: " debe tener de 6 a 20 caracteres")

    |> validate_format(:password, ~r/^(?=.*[a-z].*)(?=.*[A-Z].*)(?=.*[0-9].*)[a-zA-Z0-9]{6,20}$/,
      message:
      "should contains at least an uppercase letter, a downcase letter, at least one number, and a special character"
    )
    |> validate_confirmation(:password, message: "don't match")
    |> hash_password
  end

  def validate_email_unique(changeset, field) do
    case get_field(changeset, field) |> InstinctApi.Services.Companies.get_by_email() do
      %InstinctApi.Models.Companies.Company{} = _ -> add_error(changeset, :email, "already registered as company employer")
      _ -> changeset
    end
  end

  def validate_phone_unique(changeset, field) do
    case get_field(changeset, field) |> InstinctApi.Services.Companies.get_by_phone() do
      %InstinctApi.Models.Companies.Company{} = _ -> add_error(changeset, :phone, "already registered as job seeker")
      _ -> changeset
    end
  end

  def validate_accept_terms(changeset, field) do
    case get_field(changeset, field) do
      false = _ -> add_error(changeset, :accept_terms, ", you should accept terms and conditions before creating an account")
      _ -> changeset
    end
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    %{password_hash: password_hash} = Bcrypt.add_hash(password)
    put_change(changeset, :password_hash, password_hash)
  end

  defp hash_password(changeset), do: changeset
end
