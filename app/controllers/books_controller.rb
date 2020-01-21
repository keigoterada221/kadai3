class BooksController < ApplicationController

  before_action :authenticate_user!


	def create
		@book = Book.new(book_params)
		# 下記の行がないとuser_idが空になるためエラーが出るので注意
		@book.user_id = current_user.id

		if @book.save(book_params)
			flash[:notice] ="You have created book successfully."
		redirect_to book_path(@book.id)
		else
			# render先に@bookがないというエラーが出るため下記を追加
			@books = Book.all
			render :index
		end
	end

	def index
		@books = Book.all
		@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
		# アソシエーションした時に使える記述。@bookからユーザを特定できる
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
		# =で結ぶ際は左右のデータ型が同じで無いといけない。
		if @book.user.id != current_user.id
		   redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		if @book.update(book_params)
			flash[:notice] ="You have updated book successfully."
		redirect_to book_path(@book.id)
		else
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
