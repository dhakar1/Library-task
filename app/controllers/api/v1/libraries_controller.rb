module Api
  module V1
    class LibrariesController < ApplicationController
      before_action :authorize_request
      skip_before_action :verify_authenticity_token
      before_action :my_lib , only:[:show,:update,:destroy,:create]
      # def index
      #   @library = Library.all
      # end

      def show
        if @library.present?
         render json: @library
         else
          render json: {message:"No library found"}
        end
      end

      def create
        if @library.present?
          render json: {message: "Library already created"}
        else
          @lib = current_user.build_library(params_lib)
          @lib.save
          render json: @lib
        end
      end

      def update
        if @library.present?
          @library.update(params_lib)
          render json: @library
        else
          render json: {message: "Library not found"}
        end
      end

      def destroy
        if @library.present?
          @library.destroy
          render json: {message: "Library deleted"}
        else
          render json: {message: "Library not found"}
        end
      end
      private

      def params_lib
        params.require(:library).permit(:name,:address)
      end
      
      def my_lib
        @library = current_user.library
      end
    end
  end
end
