class SurveyMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def notification_email(addressee, name, survey)
    @addressee = addressee
    @name = name
    @survey_id = survey
    @body = body # Agregar esta línea para asignar el valor de body a @body
    @url = url
    mail(to: addressee, subject: 'We want to know more about you')
  end

  def body
    <<-BODY
      Sr.(a): #{@name}
      <br />
      Reciba un cordial saludo.
      <br />
      Queremos agradecerle por ser parte Micolet !
      <br />
      Además, nos dirigimos a usted para notificarle al responder la siguiente encuesta puede obtener un cupon de descuento
      <br />
      <br />
      <a href="#{url}" target="_blank">#{url}</a>
      <br />
      <br />
      Muchas gracias por su colaboración
      <br />
      <br />
    BODY
  end

  def url
    @url ||= survey_answers_url(type: 'new', survey_id: @survey_id)
  end
end
