class BooksCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		comment = BooksComment.new(books_comment_params)
		comment.user_id = current_user.id
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end
	def destroy
		comment = BooksComment.find(params[:id])
		comment.destroy
		redirect_to book_path
	end

	def edit
		@comment = BooksComment.find(params[:id])
		@book = Book.find(params[:book_id])
	end

	def update
		@comment = BooksComment.find(params[:id])
		@comment.update(books_comment_params)
		redirect_to book_path(@comment.book.id)
	end

	private
	def books_comment_params
		params.require(:books_comment).permit(:user_id,:book_id,:comment)
	end
end
