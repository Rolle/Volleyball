class TrainingsController < ApplicationController
  def index
    @training = Training.first
    @users = User.all.order(:name)
    @attendees = User.where(attend: true).size
    if @training.nil? 
      redirect_to action: 'new'
    end
  end

  def show
    @training = Training.find(params[:id])
  end

  def new
    @training = Training.first || Training.new
  end

  def edit
    @training = Training.find(params[:id])
  end

  def create
    @training = Training.new(training_params)
    if @training.save
      User.update_all :attend => false
      flash[:notice] = 'Training wurde gespeichert.' 
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end

  def update
    @training = Training.find(params[:id])
    if @training.update_attributes(training_params)
      User.update_all :attend => false
      User.update_all :comment => nil
      flash[:notice] =  'Training wurde gespeichert.'
      redirect_to action: 'index'
    else
      render action: "edit"
    end
  end

  def destroy
    @training = Training.find(params[:id])
    @training.destroy
    redirect_to trainings_url 
  end

  private
    def training_params
      params.require(:training).permit( :comment, :start)
    end
end
