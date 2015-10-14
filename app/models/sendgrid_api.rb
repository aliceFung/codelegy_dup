class SendgridApi

  include HTTParty
  base_uri 'https://api.sendgrid.com'

  def remove_from_unsub_list(email)
    parameters = { 
      api_user: ENV['sendgrid_api_user'],
      api_key: ENV['sendgrid_api_key'],
      email: email
    }
    self.class.post('/api/unsubscribes.delete.json', body: parameters) 
  end
end