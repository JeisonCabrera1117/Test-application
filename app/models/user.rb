class User < ApplicationRecord
  require 'net/http'
  require 'net/https'

  validates :email, presence: { if: :true_email? }
  validates :name, presence: true
  has_many :preferences, class_name: 'UserPreference', inverse_of: :user, dependent: :destroy


  private

  def true_email?
    return errors.add(:email, "email must be present") if email.nil? || email.blank?
    return errors.add(:email, "the email is already in use, please try another") if User.where(email: "#{email}").present?

    uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=bcec924d2118485798c9155414e85041&email=#{email}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request =  Net::HTTP::Get.new(uri)

    response = http.request(request)
    parsed_body = JSON.parse(response.body)
    quality_score = parsed_body['quality_score']
    errors.add(:email, 'the email is not valid, please try another') if quality_score.to_f <= 0.7
  end
end
