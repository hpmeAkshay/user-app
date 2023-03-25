class UsersController < ApplicationController
     skip_before_action :verify_authenticity_token

    def index
        # @users=User.paginate(page: params[:page], per_page: params[:per_page])
        # render json: @users
        @users=User.all
        render json: @users
    end

    def show
        @user=User.find(params[:id])
        render json: @user
    end

    def new
        @user=User.new
    end

    def create
       
        @user=User.new(user_params)

        if @user.save
            render json: @user
        else
            render json: {error: 'Unable to create user.'}, status: 400
        end
    end

    def update
        @user=User.find(params[:id])

        if @user.update(user_params)
            render json: @user
        else
            render json: {error: "Unable to update user."}, status:400
        end
    end

    def destroy
        @user=User.find(params[:id])
        @user.destroy
    end

    def typehead
        input=params[:input]
        @users=User.where('firstName LIKE ? OR lastName LIKE ? OR email LIKE ?', "%#{input}%", "%#{input}%", "%#{input}%" )
        render json: @users
    end

    private 

    def user_params
        params.require(:user).permit(:firstName, :lastName, :email)
    end
end
