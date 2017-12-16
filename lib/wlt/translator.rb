require 'net/http'

module Wlt
  class Translator

    def initialize(authenticator)
      @authenticator = authenticator
    end

    def translate(text:, source: 'en', target: 'es')
      uri = URI('https://gateway.watsonplatform.net/language-translator/api/v2/translate')
      params = { source: source, target: target, text: text }
      uri.query = URI.encode_www_form(params)

      req = Net::HTTP::Get.new(uri)
      req.basic_auth @authenticator.username, @authenticator.password

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true

      res = http.request(req)

      res.body
    end
  end
end
