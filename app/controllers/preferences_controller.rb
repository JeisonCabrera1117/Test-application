class PreferencesController < ApplicationController
  before_action :set_preference, only: %i[edit update destroy]
  def index
    @preferences = Preference.all.order(:created_at)
  end

  def new
    @preference = Preference.new
    render_form layout: 'application'
  end

  def create
    @preference = Preference.new(preference_params)
    @preference.save
    if @preference.errors.empty?
      redirect_to preferences_path
    else
      render_form layout: false
    end
  end

  def edit
    render_form layout: 'application'
  end

  def update
    if @preference.update(preference_params)
      redirect_to preferences_path
    else
      render_form status: :bad_request
    end
  end

  def destroy
    @preference.destroy
    redirect_to preferences_path
  end

  private

  def set_preference
    @preference = Preference.find(params[:id])
  end

  def preference_params
    params.require(:preference).permit(:description)
  end
end
