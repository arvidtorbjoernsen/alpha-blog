# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    # @ = .new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successlully'
      redirect_to user
    else
      flash.now[:alert] = 'There was somting wrong with your login details'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end
end
