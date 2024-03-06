class AuthsController < ApplicationController

    def index
        @auths = Auth.all
        render json: @auths
    end


    def create
        hmac_secret = "secretkey"
        payload = {name: params[:name]}
        token = JWT.encode payload, hmac_secret, "HS256"
        render json: { token: token}
    end 

end
