class UsersController < ApplicationController

def new
    @user=User.new
end

def edit
    @user=User.find(params[:id])
end

def update
    @user=User.find(params[:id])
    if @user.update(user_params)
        flash[:notice]="account is succesfully updated"
        redirect_to articles_path
    else
       render 'edit'
    end
end


def create
    @user=User.new(user_params)
    if @user.save
        flash[:notice]="welcome to alpha blog #{@user.username}, you have succesfully signed up"
        redirect_to articles_path
    else
        render 'new'
    end
end


def user_params
    params.require(:user).permit(:username,:email,:password_digest)
end

end