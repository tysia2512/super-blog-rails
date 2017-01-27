# coding: utf-8
class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password]) 
      cookies[:username] = user.name
      if user.admin
      then cookies[:admin] = true
      end
      redirect_to home_index_path
    else
    end
  end

  def destroy
    cookies.delete :username
    cookies.delete :admin
    redirect_to home_index_path
  end
end
