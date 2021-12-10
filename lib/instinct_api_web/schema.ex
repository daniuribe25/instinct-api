defmodule InstinctApiWeb.Schema do
  use Absinthe.Schema
  alias InstinctApi.Middlewares.ErrorHandler
  alias InstinctApi.Services.{Users, Companies, Posts}

  import_types(InstinctApiWeb.Graphql.Types)

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:user, Users.data())
      |> Dataloader.add_source(:company, Companies.data())
      |> Dataloader.add_source(:post, Posts.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields(:session_queries)
    import_fields(:user_queries)
    import_fields(:company_queries)
    import_fields(:post_queries)
    import_fields(:resume_queries)
    import_fields(:user_experience_queries)
    import_fields(:user_education_queries)
    import_fields(:user_application_queries)
  end

  mutation do
    import_fields(:session_mutations)
    import_fields(:user_mutations)
    import_fields(:company_mutations)
    import_fields(:post_mutations)
    import_fields(:resume_mutations)
    import_fields(:user_experience_mutations)
    import_fields(:user_education_mutations)
    import_fields(:user_application_mutations)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation] do
    middleware ++ [ErrorHandler]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end
end
