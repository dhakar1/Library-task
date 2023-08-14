module Api
  module V1
    class BooksController < ApplicationController
      before_action :authorize_request
      before_action :book, only:[:show,:update,:destroy,:book_issued]
      skip_before_action :verify_authenticity_token

      def index
        @books = current_user.library.books
        render json: @books
      end


      def show
        render json: @book
      end

      def create
        @book = current_user.library.books.create(params_book)
        render json: @book
      end

      def update
        if @book.present?
          @book.update(params_book)
          render json: @book
        else
          render json: {message: "book not found"}
        end
      end

      def destroy
        if @book.present?
          @book.destroy
          render json: {message: "Book deleted "}
        else
          render json: {message: "Book not found"}
        end
      end

      def search
        @books = Book.where("name Like ?", "%#{params[:name]}%")
        if @books.present?
          render json: @books
        else
          render json: {message: "book not found"}
        end
      end

      def book_issued
        if @book.issued_data_end.strftime("%Y-%m-%d")< params[:issued_date_start]
        @book.update(issued_date_start: params[:issued_date_start], issued_data_end: params[:issued_date_end],issued_to: current_user.id)
        render json: {message: "book issued for #{@book.issued_date_start.strftime("%d-%m-%Y")} to #{@book.issued_data_end.strftime("%d-%m-%Y")}"}
        else
          render json: {message: "book not available"} 
        end
      end


      private

      def params_book
        params.require(:book).permit(:name, :author, :description, :issued_to, :issued_date_start, :issued_data_end, :library_id,:category)
      end

      def book
        @book = Book.find_by(id:params[:id])
      end
    end
  end
end
