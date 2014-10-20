# encoding: utf-8
module LogMe
  class HttpFormatter
    def format_request(request, url)
      message = format_message(request) do
        message =  with_line_break { 'Request:' }
        message << with_line_break { "#{request.method.to_s.upcase} #{url}" }
      end
    end

    def format_response(response)
      message = format_message(response) do
        message =  with_line_break { 'Response:' }
        message << with_line_break { "HTTP/#{response.http_version} #{response.code} #{response.message}" }
      end
    end

    private

    def format_message(http)
      message = yield
      body = extract_body_from(http)
      message << with_line_break { body } unless blank?(body)
      message
    end

    def with_line_break
      "#{yield}\n"
    end

    def extract_body_from(http)
      return http.body if http.respond_to?(:body)
      return http.args[:payload] if http.respond_to?(:args)
      return nil
    end

    def blank?(text)
      text.to_s.strip.empty?
    end
  end
end
