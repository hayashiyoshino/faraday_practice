require 'faraday'

zip = Class.new do
   def url
     '/Users/hayashiyoshino/projects/mofmof/m4ware/m4ware/tmp/webletters/zip/20190816222434814/PKG00005_prezip00_20190816222434814.zip'
   end
   def filename
     'PKG00005_prezip00_20190816222434814.zip'
   end
 end

 z = zip.new

class WebletterApi
  def initialize(zip)
    @zip = zip
  end

  def post_webletter

    payload = { file: faraday_io }
    path = "/webyubin/serpos/WY0125901"
    response = connection.post(path, payload)

    if response.status == 200
      p response
      data = JSON(response.body)
    else
      p response
      puts "response_error"
    end

    data
  end

  private
    def connection
      Faraday.new(url: "https://kwebyubin.jpi.post.japanpost.jp") do |faraday|
        faraday.request :multipart
        faraday.request :url_encoded
        faraday.adapter :net_http
      end
    end

    def webletter_headers
      {
        'Content-Disposition' => "filename=#{@zip.filename}",
        'Accept' => 'application.json'
      }
    end

    def faraday_io
      Faraday::UploadIO.new(@zip.url, 'application/zip')
    end
end

webletter = WebletterApi.new(z)
webletter.post_webletter

