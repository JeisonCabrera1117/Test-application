class ApplicationController < ActionController::Base
  def index
    
  end

  def render_form(options = {})
    render 'form', { layout: false }.merge(options)
  end
end
