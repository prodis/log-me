require 'spec_helper'

describe LogMe::NetHttpFormatter do
  describe "#format_request" do
    let(:request) do
      double "Net::HTTP::Post", method: "POST", body: "param1=value1&param2=value2"
    end
    let(:url) { "http://prodis.blog.br" }

    it "formats request message" do
      expected_message = "Request:\nPOST #{url}\nparam1=value1&param2=value2\n"
      expect(subject.format_request(request, url)).to eq expected_message
    end
  end

  describe "#format_response" do
    let(:response) do
      double "Net::HTTP::OK", http_version: "1.1", code: "200", message: "OK", body: "<xml><fake />"
    end

    it "formats response message" do
      expected_message = "Response:\nHTTP/1.1 200 OK\n<xml><fake />\n"
      expect(subject.format_response(response)).to eq expected_message
    end
  end
end
