class SurveyAnswersController < ApplicationController
  before_action :set_suvery_answer, only: %i[update]
  def index
    if params[:type] == 'new'
      
      question = SurveyQuestion.where(position: 1).order(created_at: :asc).first
      @survey_question = question.description
      @survey_question_id = question.id
      @survey_id = params[:survey_id]
      @position = question.position
      @maximum =  SurveyQuestion.all.maximum(:position)
      @survey_answer = SurveyAnswer.new
      @survey_answer = SurveyAnswer.find_by(survey_id: params[:survey_id], survey_question_id: @survey_question_id) if SurveyAnswer.where(survey_id: params[:survey_id], survey_question_id: @survey_question_id).present?
    elsif params[:type] == 'next'
      number = params[:position].to_i + 1
      question = SurveyQuestion.where(position: number).order(created_at: :asc).first
      @position = question.position
      @survey_question = question.description
      @survey_question_id = question.id
      @survey_id = params[:survey_id]
      @survey_answer = SurveyAnswer.new
      @survey_answer = SurveyAnswer.find_by(survey_id: params[:survey_id], survey_question_id: @survey_question_id) if SurveyAnswer.where(survey_id: params[:survey_id], survey_question_id: @survey_question_id).present?
      @maximum =  SurveyQuestion.all.maximum(:position)
    elsif params[:type] == 'back'
      number = params[:position].to_i - 1
      question = SurveyQuestion.where(position: number).order(created_at: :asc).first
      @position = question.position
      @survey_question = question.description
      @survey_question_id = question.id
      @survey_id = params[:survey_id]
      @survey_answer = SurveyAnswer.new
      @survey_answer = SurveyAnswer.find_by(survey_id: params[:survey_id], survey_question_id: @survey_question_id) if SurveyAnswer.where(survey_id: params[:survey_id], survey_question_id: @survey_question_id).present?
      @maximum =  SurveyQuestion.all.maximum(:position)
    elsif params[:type] == 'finish'
      redirect_to root_path
    end

  end

  def create
    @survey_answer = SurveyAnswer.new(params_answer_survey)
    if @survey_answer.save
      if params[:commit] == 'next'
        redirect_to survey_answers_path(type: 'next',
                                        survey_id: params[:survey_answer][:survey_id],
                                        position: params[:survey_answer][:position])
      elsif params[:commit] == 'back'
        redirect_to survey_answers_path(type: 'back',
                                        survey_id: params[:survey_answer][:survey_id],
                                        position: params[:survey_answer][:position])
      elsif params[:commit] == 'finish'
        redirect_to root_path
      end
    end
  end

  def update
    if @survey_answer.update(params_answer_survey)
      if params[:commit] == 'next'
        redirect_to survey_answers_path(type: 'next',
                                        survey_id: params[:survey_answer][:survey_id],
                                        position: params[:survey_answer][:position])
      elsif params[:commit] == 'back'
        redirect_to survey_answers_path(type: 'back',
                                        survey_id: params[:survey_answer][:survey_id],
                                        position: params[:survey_answer][:position])
      elsif params[:commit] == 'finish'
        redirect_to root_path
      end
    end
  end


  private

  def set_suvery_answer
    @survey_answer = SurveyAnswer.find(params[:id])
  end

  def params_answer_survey
    params.require(:survey_answer).permit(:survey_id, :survey_question_id, :answer)
  end
end
