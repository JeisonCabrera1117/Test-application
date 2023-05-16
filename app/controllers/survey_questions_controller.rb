class SurveyQuestionsController < ApplicationController
  before_action :set_survey_questions, only: %i[destroy edit update]
  def index
    @survey_questions = SurveyQuestion.all
    render 'index'
  end

  def new
    @survey_question = SurveyQuestion.new
    @position = (SurveyQuestion.order(created_at: :asc).last&.position || 0) + 1
    render 'form'
  end

  def create
    @survey_question = SurveyQuestion.new(params_survey_questions)
    if @survey_question.save
      flash[:success] = t("survey_question.notification.success")
      redirect_to survey_questions_path
    else
      render_form status: :bad_request
    end
  end

  def destroy
    if @survey_question.destroy
      flash[:success] = t("survey_question.notification.succes_destroy")
    else
      flash[:error] = t("survey_question.notification.error_destroy")
    end  
    redirect_to survey_questions_path
  end

  def edit
    render_form layout: 'application'
  end

  def update
    if @survey_question.update(params_survey_questions)
      redirect_to survey_questions_path
    else
      render_form status: :bad_request
    end
  end

  private

  def set_survey_questions
    @survey_question = SurveyQuestion.find(params[:id])
  end

  def params_survey_questions
    params.require(:survey_question).permit(:description, :position)
  end
end
