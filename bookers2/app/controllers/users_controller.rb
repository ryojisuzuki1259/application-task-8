class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user  = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end


  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    # binding.pry
    # @book = Book.find(params[:id])
    @new = Book.new
    @book_comment = BookComment.new
    @books = @user.books
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    # @book = Book.find(params[:id])
    @new = Book.new
    @book_comment = BookComment.new
    @books = @user.books
    render 'show_follower'
  end



  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
