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

    #USUARIOS
    get "/", WelcomeController, :index
    post "/usuarios", UsuariosController, :create
    post "/usuarios/signin", UsuariosController, :sign_in

    ## PARA TESTE --> André
    get "/usuarios/list", UsuariosController, :show_list
  end

  scope "/api", GoreviewapiWeb do
    ## ROTAS AUTENTICADAS
    pipe_through [:api, :auth]

    #USUARIOS
    get "/usuarios", UsuariosController, :index
    delete "/usuarios", UsuariosController, :delete
    put "/usuarios", UsuariosController, :update

    #TURMAS
    post "/turmas", TurmasController, :create
    put "/turmas", TurmasController, :update
    get "/turmas", TurmasController, :index
    get "/turmas/list", TurmasController, :show_list

    #DESAFIOS
    post "/desafios", DesafiosController, :create
    put "/desafios", DesafiosController, :update
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
