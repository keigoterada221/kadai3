class BooksController < ApplicationController
	# newアクションを消してindexに追記
	def index
		@books = Book.all
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		# 下記の行がないとuser_idが空になるためエラーが出るので注意
		@book.user_id = current_user.id
		@book.save
		# 投稿後に投稿詳細画面へ
		redirect_to book_path(@book.id)
	end

	def show
		@book = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		book = Book.find(params[:id])
		book.update(book_params)
		redirect_to book_path(book.id)
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
