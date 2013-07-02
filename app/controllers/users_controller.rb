class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params_user)
    @user.attend = true
    if @user.save
      flash[:notice] = 'Teilnehmer wurde angelegt.'
      redirect_to controller: 'trainings', action: 'index'
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params_user)
       flash[:notice] = 'Teilnehmer wurde gespeichert.'
      redirect_to controller: 'trainings', action: 'index'
    else
      render action: "edit" 
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private
    def params_user
      params.require(:user).permit(:attend, :name, :comment)
    end
end
