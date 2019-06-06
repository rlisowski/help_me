# frozen_string_literal: true

require 'net/https'

class Translator
  class MicrosoftTranslator
    def call(text)
      content = [{ Text: text }].to_json

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request(content))
      end

      parse JSON.parse(response.body.force_encoding('utf-8'))
    end

    private

    def uri
      @uri ||= URI::HTTPS.build(host: HOST, path: PATH, query: query)
    end

    def request(content)
      request = Net::HTTP::Post.new(uri)
      request['Content-type'] = 'application/json'
      request['Content-length'] = content.length
      request['Ocp-Apim-Subscription-Key'] = API_KEY
      request['X-ClientTraceId'] = SecureRandom.uuid
      request.body = content

      request
    end

    def query
      { 'api-version': '3.0',
        to: :de }.to_query
    end

    def parse(response)
      response.first['translations'].first['text']
    end

    HOST = 'api-eur.cognitive.microsofttranslator.com'
    private_constant :HOST

    PATH = '/translate'
    private_constant :PATH

    API_KEY = ENV.fetch('MICROSOFT_TRANSLATOR_API_KEY')
    private_constant :API_KEY
  end
end
