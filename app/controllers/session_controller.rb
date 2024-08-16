class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:current_user_id] = user.id
      flash[:notice] = "You have successfully log in."
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login details"
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session.destroy(:current_user_id)
    @_current_user = nil
    flash[:error] = "You have successfully logged out."
    redirect_to root_path
  end
end
