defmodule GoreviewapiWeb.WelcomeController do
  use GoreviewapiWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text(~s(GoReview API - Time Ignautas
    Code/Station RocketSeat Hackathon

    Available routes
       welcome_path  GET     /api                     GoreviewapiWeb.WelcomeController :index
      usuarios_path  POST    /api/usuarios            GoreviewapiWeb.UsuariosController :create
      usuarios_path  POST    /api/usuarios/reset      GoreviewapiWeb.UsuariosController :reset
      usuarios_path  POST    /api/usuarios/signin     GoreviewapiWeb.UsuariosController :sign_in
      usuarios_path  GET     /api/usuarios/list       GoreviewapiWeb.UsuariosController :show_list
      usuarios_path  GET     /api/usuarios            GoreviewapiWeb.UsuariosController :index
      usuarios_path  DELETE  /api/usuarios            GoreviewapiWeb.UsuariosController :delete
      usuarios_path  PUT     /api/usuarios            GoreviewapiWeb.UsuariosController :update
        turmas_path  POST    /api/turmas              GoreviewapiWeb.TurmasController :create
        turmas_path  PUT     /api/turmas              GoreviewapiWeb.TurmasController :update
        turmas_path  GET     /api/turmas/list         GoreviewapiWeb.TurmasController :show_list
        turmas_path  GET     /api/turmas/user/:id     GoreviewapiWeb.TurmasController :show_user
        turmas_path  GET     /api/turmas/:id          GoreviewapiWeb.TurmasController :index
        turmas_path  DELETE  /api/turmas/:id          GoreviewapiWeb.TurmasController :delete
      desafios_path  POST    /api/desafios            GoreviewapiWeb.DesafiosController :create
      desafios_path  PUT     /api/desafios            GoreviewapiWeb.DesafiosController :update
      desafios_path  GET     /api/desafios/list       GoreviewapiWeb.DesafiosController :show_list
      desafios_path  GET     /api/desafios/class/:id  GoreviewapiWeb.DesafiosController :show_class
      desafios_path  GET     /api/desafios/:id        GoreviewapiWeb.DesafiosController :index
      desafios_path  DELETE  /api/desafios/:id        GoreviewapiWeb.DesafiosController :delete
        envios_path  POST    /api/envios              GoreviewapiWeb.EnviosController :create
        envios_path  PUT     /api/envios              GoreviewapiWeb.EnviosController :update
      desafios_path  GET     /api/envios/list         GoreviewapiWeb.DesafiosController :show_list
     revisores_path  PUT     /api/revisores           GoreviewapiWeb.RevisoresController :update

     See documentation in
     https://documenter.getpostman.com/view/15643514/TzeWFT1o
    ))
  end
end
