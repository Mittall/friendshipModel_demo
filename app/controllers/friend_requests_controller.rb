class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend_request, only: [:show, :edit, :update, :destroy]

  def index
    @friend_requests = FriendRequest.all
  end

  def show
  end

  def new
    @friend_request = FriendRequest.new
  end

  def edit
  end

  def create
    @friend_request = FriendRequest.new(friend_request_params)
    respond_to do |format|
      if @friend_request.save
        format.html { redirect_to @friend_request, notice: 'Friend request was successfully created.' }
        format.json { render :show, status: :created, location: @friend_request }
      else
        format.html { render :new }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def send_request
    @friend_request = FriendRequest.new
    @friend_request.user_id = current_user.id
    @friend_request.requested_user_id = params[:uId]
    @friend_request.status = "pendding"
    respond_to do |format|
      if @friend_request.save
        format.html { redirect_to @friend_request, notice: 'Friend request was successfully created.' }
        format.json { render :show, status: :created, location: @friend_request }
      else
        format.html { render :new }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def process_request
    if params[:uId].present? && params[:status].present?
      @friend_request = FriendRequest.find_by_user_id(params[:uId])
      @friend_request.status = params[:status]
      @friend_request.save
    end
    @user_friend = UserFriend.new
    @user_friend.user_id = @friend_request.user_id
    @user_friend.friend_id = @friend_request.requested_user_id
    respond_to do |format|
      if @user_friend.save
        format.html { redirect_to @user_friend, notice: 'Friend request was successfully created.' }
        format.json { render :process_request, status: :created, location: @user_friend }
      else
        format.html { render :new }
        format.json { render json: @user_friend.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @friend_request.update(friend_request_params)
        format.html { redirect_to @friend_request, notice: 'Friend request was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend_request }
      else
        format.html { render :edit }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friend_request.destroy
    respond_to do |format|
      format.html { redirect_to friend_requests_url, notice: 'Friend request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_friend_request
      @friend_request = FriendRequest.find(params[:id])
    end

    def friend_request_params
      params.require(:friend_request).permit! #(:requested_user_id, :user_id, :status)
    end
end
