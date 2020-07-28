class SessionsController < ApplicationController

  def new

  end

  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)

    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      cookies.encrypted[:chef_id] = chef.id
      flash[:success] = "You have successfully logged in"
      redirect_to chef
    else
      flash.now[:danger] = "There is something wrong with your credentials"
      render 'new'
    end

  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have been logged out"
    redirect_to root_path
  end

end