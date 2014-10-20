module LogMe
  class NetHttpFormatter
    def format_request(request, url)
      message = format_message(request) do
        message =  with_line_break { 'Request:' }
        message << with_line_break { "#{request.method} #{url}" }
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
      message << with_line_break { http.body } if has_body?(http)
      message
    end

    def with_line_break
      "#{yield}\n"
    end

    def has_body?(http)
      http.body && !http.body.strip.empty?
    end
  end
end
