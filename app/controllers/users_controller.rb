class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where("id != ?", current_user.id)

    #@status = FriendRequest.find_by_user_id(@users.id)
    #return render :text => @status.status

    #@friend_list = []
    #@users.each do |user|
      #@friend_list << FriendRequest.where("requested_user_id = ?", user.id)
    #end
    #return render :text => @friend_request.inspect
    #requested_users ma @users ma je avya e id na hoy eva j user liast karvana
    #friend_request
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

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

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def friend_request
    @friend_request = FriendRequest.where("requested_user_id = ?", current_user.id)
    if @friend_request.present?
      @user = []
      @userdetail = []
      @friend_request.each do |fr|
        @userdetail << User.find_by_id(fr.user_id)
      end
    else
      #return render :text => "else"
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit!
    end
end
