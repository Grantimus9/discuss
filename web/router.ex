defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Discuss.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    get "/", JobController, :index

    resources "/jobs", JobController
    resources "/batches", BatchController
    get "/batches/:id/options", BatchController, :options
    put "/batches/:id/options", BatchController, :options
    get "/batches/:id/options/publish", BatchController, :publish
    put "/batches/:id/options/publish", BatchController, :publish
    resources "/topics", TopicController
    resources "/htasks", HtaskController
    post "/htasks/:id/submit_work", HtaskController, :submit_work
  end

  scope "/auth", Discuss do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
