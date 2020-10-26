class SearchController < ApplicationController

  def search
    @users = User.all
    @book = Book.new
    @user = current_user
    
    # binding.pry
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    
    if @range == '1'
      @user_s = User.search(search, word)
    else
      @book_s = Book.search(search, word)
    end
    
  end

end
