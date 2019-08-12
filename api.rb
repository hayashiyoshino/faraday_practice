require 'faraday'
require 'json'

conn = Faraday::Connection.new(:url => 'http://qiita.com') do |builder|
  builder.use Faraday::Request::UrlEncoded
  builder.use Faraday::Response::Logger
  builder.use Faraday::Adapter::NetHttp
end

response = conn.get do |request|
  request.url '/api/v2/teams'
end
json = JSON.parser.new(response.body)
p json.parse
