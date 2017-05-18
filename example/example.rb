$:.push File.dirname(__FILE__) + '/../lib'

require 'omniauth-outlook'
require 'sinatra'
require 'json'

set :port, 4200

client_id = ENV['AZURE_APPLICATION_CLIENT_ID']
secret = ENV['AZURE_APPLICATION_CLIENT_SECRET']

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :outlook, client_id, secret
end

get '/' do
  "<a href='/auth/outlook'>Log in with Microsoft</a>"
end

get '/auth/outlook/callback' do
  content_type 'text/plain'
  request.env['omniauth.auth'].to_json
end

get '/auth/failure' do
  content_type 'text/plain'
  params.to_json
end
