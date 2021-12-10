defmodule InstinctApiWeb.Graphql.Types.UserApplication do
  use Absinthe.Schema.Notation
  alias InstinctApiWeb.Graphql.Resolvers.UserApplication, as: UserApplicationResolvers
  alias InstinctApi.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "User Experience"
  object :user_application do
    field :id, :id, description: "user application unique identifier"
    field :active, :boolean, description: "is application active"
    field :post_id, :integer, description: "post id"
    field :user_id, :integer, description: "user owner id"
    field :user, :user, resolve: dataloader(:user)
    field :post, :post, resolve: dataloader(:post)
    field :inserted_at, :string, description: "time that user application was inserted"
  end

  @desc "user_experience filter"
  input_object :user_application_filters, description: "user_experience filter input" do
    field :id, :filter_operators, description: "user experience unique identifier"
    field :post_id, :filter_operators, description: "post id"
    field :user_id, :filter_operators, description: "user owner id"

    field :or, list_of(:user_application_filters)
  end

  @desc "user experience order"
  input_object :user_application_order, description: "user experience sorting input" do
    field :id, :order_by_operators, description: "user experience title"
    field :post_id, :order_by_operators, description: "post id"
    field :user_id, :order_by_operators, description: "user owner id"
    field :inserted_at, :order_by_operators, description: "time that user experience was inserted"
  end

  # QUERIES
  object :user_application_queries do
    @desc "Get all the user applications"
    field :user_applications, list_of(:user_application) do
      arg :filter, :user_application_filters
      arg :order_by, :user_application_order
      arg :pagination, :pagination_input

      middleware(AuthorizeMiddleware, [:employer, :admin, :seeker])
      resolve &UserApplicationResolvers.list/3
    end
  end

  # MUTATIONS
  object :user_application_mutations do
    @desc "User applies to a post job"
    field :apply_to_job, type: :user_application do
      arg(:post_id, non_null(:integer))

      middleware(AuthorizeMiddleware, [:seeker, :admin])
      resolve(&UserApplicationResolvers.create/2)
    end
  end
end
