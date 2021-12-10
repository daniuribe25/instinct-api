defmodule InstinctApiWeb.Graphql.Types.Users do
  use Absinthe.Schema.Notation
  alias InstinctApiWeb.Graphql.Resolvers.Users, as: UserResolvers
  alias InstinctApi.Middlewares.Authorize, as: AuthorizeMiddleware

  # TYPES
  @desc "Platform user definition"
  object :user do
    field :id, :id, description: "user unique identifier"
    field :fullname, :string, description: "user fullname"
    field :phone, :string, description: "user phone"
    field :email, :string, description: "user email"
    field :role, :string, description: "user role"
    field :inserted_at, :string, description: "time that user was inserted"
  end

  @desc "User info to be created"
  input_object :create_user_params, description: "Create user" do
    field :fullname, non_null(:string), description: "user last name"
    field :email, non_null(:string), description: "user email"
    field :phone, :string, description: "optional user phone"
    field :password, non_null(:string), description: "user password with regex validation"
    field :password_confirmation, non_null(:string), description: "user password with regex validation"
    field :accept_terms, non_null(:boolean), description: "user accepts terms and conditions"
    field :role, :string, description: "user role"
  end

  @desc "user filter"
  input_object :user_filters, description: "user filter input" do
    field :fullname, :filter_operators, description: "user fullname"
    field :email, :filter_operators, description: "user email"
    field :phone, :filter_operators, description: "user phone"
    field :role, :filter_operators, description: "user role"

    field :or, list_of(:user_filters)
  end

  @desc "user order"
  input_object :user_order, description: "user sorting input" do
    field :id, :order_by_operators, description: "user id"
    field :fullname, :order_by_operators, description: "user fullname"
    field :email, :order_by_operators, description: "user email"
    field :phone, :order_by_operators, description: "user phone"
    field :inserted_at, :order_by_operators, description: "time that user was inserted"
  end

  # QUERIES
  object :user_queries do
    @desc "Get all the users"
    field :users, list_of(:user) do
      arg :filter, :user_filters
      arg :order_by, :user_order
      arg :pagination, :pagination_input

      middleware(AuthorizeMiddleware, [:admin])
      resolve(&UserResolvers.list/3)
    end

    @desc "Get user by id"
    field :user_by_id, :user do
      arg(:id, non_null(:id))

      middleware(AuthorizeMiddleware, [:seeker, :admin])
      resolve(&UserResolvers.by_id/2)
    end
  end

  # MUTATIONS
  object :user_mutations do
    @desc "Create new User"
    field :create_user, type: :user do
      arg(:user, :create_user_params)

      resolve(&UserResolvers.create/2)
    end
  end
end
