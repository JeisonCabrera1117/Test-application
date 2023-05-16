class UsersController < ApplicationController
  def new
    @user  = User.new
    render_form layout: 'application'
  end

  def create
    @user = User.new(user_params)
    preferences = params.dig(:user, :preferences, :preference_ids)
    @user.errors.add(:preference, 'the presferences is not valid, please try another') if preferences.first.blank?
    if @user.save
      preferences.each do |preference_id|
        next if preference_id.blank?

        UserPreference.new(user_id: @user.id, preference_id: preference_id).save!
      end
      @survey = Survey.new(user_id: @user.id)
      @survey.save
      SurveyMailer.notification_email(@user.email, @user.name, @survey.id).deliver_now
      flash[:success] = "El empleado \"#{@user.name}\" fue creado(a) exitosamente y se envío un correo al usuario registrado"
      redirect_to root_path
    else
      render_form status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, preference_attributes: %i[id preference_id])
  end
end
