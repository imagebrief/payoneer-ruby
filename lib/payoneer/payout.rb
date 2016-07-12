module Payoneer
  class Payout
    CREATE_PAYOUT_API_METHOD_NAME = 'PerformPayoutPayment'

    def self.create(options={program_id: nil, payment_id: nil, payee_id: nil, amount: nil, description: nil, payment_date: Time.now, currency: 'USD'})
      payoneer_params = {
        p4: options[:program_id],
        p5: options[:payment_id],
        p6: options[:payee_id],
        p7: '%.2f' % options[:amount],
        p8: options[:description],
        p9: options[:payment_date].strftime('%m/%d/%Y %H:%M:%S'),
        Currency: options[:currency],
      }

      response = Payoneer.make_api_request(CREATE_PAYOUT_API_METHOD_NAME, payoneer_params)

      Response.new(response['Status'], response['Description'])
    end
  end
end
