require 'uri'

module Payoneer
  class Payee
    SIGNUP_URL_API_METHOD_NAME = 'GetToken'

    def self.signup_url(payee_id, payout_method="IACH", existing_account=false, redirect_url=nil, redirect_time=nil)
      payoneer_params = {
        p4: payee_id,
        p6: redirect_url,
        p8: redirect_time,
        p9: Payoneer.configuration.auto_approve_sandbox_accounts?,
        p10: true, # returns an xml response
        p11: payout_method,
      }

      payoneer_params = payoneer_params.merge({p12: "AlreadyHaveAnAccount"}) if existing_account 

      response = Payoneer.make_api_request(SIGNUP_URL_API_METHOD_NAME, payoneer_params)

      if success?(response)
        Response.new_ok_response(response['Token'])
      else
        Response.new(response['Code'], response['Description'])
      end
    end

    private

    def self.success?(response)
      !response.has_key?('Code')
    end

  end
end
