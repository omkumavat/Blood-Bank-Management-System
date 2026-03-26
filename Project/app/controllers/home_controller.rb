class HomeController < ApplicationController
  layout "home"
  def index
  end

    
  def set_theme
    current_theme=cookies[:theme]
    # theme = params[:theme] == "true"
    new_theme = current_theme == "light" ? "dark" : "light"
    cookies[:theme] = {
      value: new_theme,
      expires: 1.year.from_now
    }

    redirect_back fallback_location: home_path
  end
end
