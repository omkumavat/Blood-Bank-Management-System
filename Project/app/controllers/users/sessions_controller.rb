# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
 
  def oauth_callback
    token     = exchange_code_for_token(params[:code])
    user_info = fetch_user_info(token)

    if user_info.nil? || user_info["email"].nil?
      redirect_to new_user_session_path, alert: "Google authentication failed."
      return
    end

    user = User.find_by(uid: user_info["sub"], provider: "google")
    user ||= User.find_by(email: user_info["email"])
    name_parts = user_info["name"].to_s.split(" ")

    unless user
      user = User.new(
        email:      user_info["email"],
        first_name: name_parts[0],
        last_name:  name_parts[1..].join(" "),
        uid:        user_info["sub"],
        provider:   "google",
        # password:   SecureRandom.hex(16),
      )
      unless user.save
        redirect_to new_user_session_path, alert: user.errors.full_messages.join(", ")
        return
      end
    end

    self.resource = user
    sign_in(:user, user)
    session[:test]="hello"
    
    if user.phone_number.blank?
      redirect_to complete_profile_path, notice: "Please complete your profile."
    else
      redirect_to after_sign_in_path_for(user)
    end
  end

    private

  def exchange_code_for_token(code)
    uri = URI("https://oauth2.googleapis.com/token")
    response = Net::HTTP.post_form(uri, {
      code:          code,
      client_id:     Rails.application.credentials.dig(:google, :client_id),
      client_secret: Rails.application.credentials.dig(:google, :client_secret),
      redirect_uri:  "http://localhost:3000/auth/callback",
      grant_type:    "authorization_code"
    })
    body = JSON.parse(response.body)
    return nil if body["error"].present?
    body["access_token"]
  rescue => e
    Rails.logger.error "Token exchange failed: #{e.message}"
    nil
  end

  def fetch_user_info(token)
    uri = URI("https://www.googleapis.com/oauth2/v3/userinfo")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{token}"
    response = http.request(request)
    body = JSON.parse(response.body)
    return nil if body["error"].present?
    body
  rescue => e
    Rails.logger.error "Fetch user info failed: #{e.message}"
    nil
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end