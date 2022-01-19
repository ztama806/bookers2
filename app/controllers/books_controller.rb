class BooksController < ApplicationController
  def new
    @book = Book.new  
  end

  def create
    @book = Book.new(post_image_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to post_images_path  
  end

  def index
    @book = Book.all  
  end

  def show
    @book = Book.find(params[:id])  
  end

  def destroy
  end    
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body) 
  end
  
end
