class UsersController < ApplicationController

  before_action :set_team, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @users = User.find(params[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params.merge({ :team => @team}))
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = @team.users.find(params[:user_id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_team
      @teams = Team.all
    end

    def user_params
      params.require(:user).permit(:name, :email, :team)
    end
end
