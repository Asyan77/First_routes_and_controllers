class UsersController < ApplicationController
    def index
        users = User.all 
        render json: users 
    end

    def create
        user = User.new(params.require(:user).permit(:name,:email))
        if user.save
            render json: user
        else 
            render json: user.errors.full_messages, status: :unprocessable_entity 
        end
    end

    def show
        user = User.find_by(id:params[:id])  # if user not find it will return nil 
        if user 
            render json: user
        else
            render plain: "user not found", status: 404 # cannot use user.errors as only nil returned before User.find_by
        end
    end
    
    def destroy
        user = User.find_by(id:params[:id])
        user.destroy
            redirect_to users_url # take us to the index 
      

    end

    def update
        user = User.find_by(id:params[:id])
       
        if user.update(user_params)
            redirect_to user_url(user) # take us to the specific individual
        else
            render json: user.errors.full_messages, status: 422
        end
    end

    private 
    def user_params
        params.require(:user).permit(:name,:email)
    end

end