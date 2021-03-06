defmodule GoreviewapiWeb.Router do
  use GoreviewapiWeb, :router

  alias GoreviewapiWeb.Plugs.UUIDChecker

  pipeline :api do
    plug CORSPlug,
      origin: ["*"],
      allow_credentials: true

    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :auth do
    plug GoreviewapiWeb.Auth.Pipeline
  end

  scope "/api", GoreviewapiWeb do
    pipe_through :api

    # USUARIOS
    get "/", WelcomeController, :index
    post "/usuarios", UsuariosController, :create
    post "/usuarios/reset", UsuariosController, :reset
    post "/usuarios/signin", UsuariosController, :sign_in
    get "/usuarios/list", UsuariosController, :show_list
  end

  scope "/api", GoreviewapiWeb do
    ## ROTAS AUTENTICADAS
    pipe_through [:api, :auth]

    # USUARIOS
    get "/usuarios", UsuariosController, :index
    delete "/usuarios", UsuariosController, :delete
    put "/usuarios", UsuariosController, :update

    # TURMAS
    post "/turmas", TurmasController, :create
    put "/turmas", TurmasController, :update
    get "/turmas/list", TurmasController, :show_list
    get "/turmas/user/:id", TurmasController, :show_user
    get "/turmas/:id", TurmasController, :index
    delete "/turmas/:id", TurmasController, :delete

    # DESAFIOS
    post "/desafios", DesafiosController, :create
    put "/desafios", DesafiosController, :update
    get "/desafios/list", DesafiosController, :show_list
    get "/desafios/class/:id", DesafiosController, :show_class
    get "/desafios/:id", DesafiosController, :index
    delete "/desafios/:id", DesafiosController, :delete

    # ENVIOS
    post "/envios", EnviosController, :create
    put "/envios", EnviosController, :update
    get "/envios/list", DesafiosController, :show_list

    # REVISORES
    put "/revisores", RevisoresController, :update
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GoreviewapiWeb.Telemetry
    end
  end
end
