class UsuariosController < ApplicationController

	before_action :authorize, except: [:new, :create]
	before_action :correct_user?, only: [:edit, :update, :destroy]

	def index
		@usuarios = Usuario.all
	end

	def show
		@usuario = Usuario.find(params[:id])
	end

  def new
  	@usuario = Usuario.new
  	render :layout => false
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      redirect_to @usuario, notice: "Usuário criado com sucesso!"
			sign_in(@usuario)
    else
			render action: :new, :layout => false
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update_attributes(usuario_params)
      redirect_to usuarios_path
    else
      render action: :edit
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    sign_out
    redirect_to root_path
  end

  private
    def usuario_params
      params.require(:usuario).permit(:nome, :email, :password, :password_confirmation)
    end

end
