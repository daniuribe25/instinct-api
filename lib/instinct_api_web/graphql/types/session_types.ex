defmodule InstinctApiWeb.Graphql.Types.Sessions do
  use Absinthe.Schema.Notation
  alias InstinctApiWeb.Graphql.Resolvers.Session, as: SessionResolvers

  # TYPES
  @desc "Platform user definition"
  object :session do
    field :token, :id, description: "user token"
    field :user, :user, description: " logged in user"
    field :company, :company, description: " logged in company"
  end

  @desc "User info to be created"
  input_object :authenticate_input, description: "Authenticate user" do
    field :email, non_null(:string), description: "user email"
    field :password, non_null(:string), description: "user password"
  end

  # QUERIES
  object :session_queries do
    @desc "Get own User or Company information by logged token"
    field :get_own_info, :session do
      resolve(&SessionResolvers.get_own/2)
    end
  end

  # MUTATIONS
  object :session_mutations do
    @desc "Authenticate User"
    field :authenticate, type: :session do
      arg(:credentials, :authenticate_input)

      resolve(&SessionResolvers.authenticate/2)
    end
  end
end
