class GoalsController < ApplicationController

  before_action :ensure_logged_in
  before_action :redirect_if_not_owner, only: [:edit, :update]

  def index
    @goals = Goal.all
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(current_user)
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def toggle_completion
    @goal = Goal.find(params[:id])
    @goal.toggle_completion
    redirect_to user_url(@goal.user)
  end

  private

  def redirect_if_not_owner
   goal = Goal.find(params[:id])
   owner_id = goal.user_id
   redirect_to user_url(current_user) if owner_id != current_user.id
  end

  def goal_params
    params.require(:goal).permit([:user_id, :body, :private])
  end
end
