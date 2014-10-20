# encoding: utf-8
require 'spec_helper'

describe LogMe::Formatter::NetHttp do
  describe '#format_request' do
    context 'when request has body' do
      let(:request) do
        double('Net::HTTP::Post', method: 'POST', body: 'param1=value1&param2=value2')
      end
      let(:url) { 'http://prodis.blog.br' }

      it 'formats request message including body' do
        expected_message = "Request:\nPOST #{url}\nparam1=value1&param2=value2\n"
        expect(subject.format_request(request, url)).to eq expected_message
      end
    end

    context 'when request does not have body' do
      let(:request) do
        double('Net::HTTP::Get', method: 'GET', body: nil)
      end
      let(:url) { 'http://prodis.blog.br?s=logme+gem' }

      it 'formats request message without body' do
        expected_message = "Request:\nGET #{url}\n"
        expect(subject.format_request(request, url)).to eq expected_message
      end
    end
  end

  describe '#format_response' do
    let(:response) do
      double('Net::HTTP::OK', http_version: '1.1', code: '200', message: 'OK', body: '<xml><fake />')
    end

    it 'formats response message' do
      expected_message = "Response:\nHTTP/1.1 200 OK\n<xml><fake />\n"
      expect(subject.format_response(response)).to eq expected_message
    end
  end
end
