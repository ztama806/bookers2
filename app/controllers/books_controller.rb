class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  protect_from_forgery

  def index
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
    @books = Book.all
    @user = current_user
      render :index
    end  
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end  
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end  

end
