class SessionsController < ApplicationController

	before_action :block_access, except: [:destroy]

  def new
  	render :layout => false
  end

  def create
  	@usuario = Usuario.find_by(email: params[:session][:email].downcase)
    if @usuario && @usuario.authenticate(params[:session][:password])
      sign_in(@usuario)
      redirect_to compromissos_path
    else
    	# render action: :new
      flash[:notice] = "Verifique se seus dados estão corretos!"
      redirect_to action: :new
  	end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
