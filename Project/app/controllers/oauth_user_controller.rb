# app/controllers/oauth_controller.rb
require 'net/http'
require 'json'
require 'uri'

class OauthUserController < ApplicationController
  include Devise::Controllers::Helpers
  include Devise::Controllers::Rememberable
  # skip_before_action :verify_authenticity_token, only: [:callback]

  def signout
    sign_out(:user)
    redirect_to home_path, notice: "Signed out successfully."
  end

  def redirect
    client_id = Rails.application.credentials.dig(:google, :client_id)
    # puts "------ #{client_id}"
    redirect_uri = "http://localhost:3000/auth/callback"
    
    scope        = "email profile"

    url = "https://accounts.google.com/o/oauth2/auth?" + URI.encode_www_form(
      client_id:     client_id,
      redirect_uri:  redirect_uri,
      scope:         scope,
      response_type: "code",
      access_type:   "online"
    )

    redirect_to url, allow_other_host: true
  end

  
end