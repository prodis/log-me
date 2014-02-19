require 'spec_helper'

module FakeModule
  extend LogMe
end

describe LogMe do
  let(:subject) { FakeModule }

  describe "#log_enabled?" do
    it "default is true" do
      expect(subject).to be_log_enabled
    end

    context "when log is disabled" do
      around do |example|
        subject.configure { |config| config.log_enabled = false }
        example.run
        subject.configure { |config| config.log_enabled = true }
      end

      it "returns false" do
        expect(subject).to_not be_log_enabled
      end
    end
  end

  describe "#log_level" do
    it "default is info" do
      expect(subject.log_level).to eq :info
    end

    context "when log level is set" do
      around do |example|
        subject.configure { |config| config.log_level = :debug }
        example.run
        subject.configure { |config| config.log_level = :info }
      end

      it "returns set level" do
        expect(subject.log_level).to eq :debug
      end
    end
  end

  describe "#log_label" do
    it "default is current module name" do
      #require 'pry'; binding.pry
      expect(subject.log_label).to eq subject.name
    end

    context "when set label" do
      around do |example|
        subject.configure { |config| config.log_level = :debug }
        example.run
        subject.configure { |config| config.log_level = :info }
      end

      it "returns label" do
        subject.configure { |config| config.log_label = "Prodis #15" }
        expect(subject.log_label).to eq "Prodis #15"
      end
    end
  end

  describe "#logger" do
    it "default is Logger" do
      expect(subject.logger).to be_a(::Logger)
    end

    context "when set logger" do
      it "returns set logger" do
        fake_logger = Class.new
        subject.configure { |config| config.logger = fake_logger }
        expect(subject.logger).to eq fake_logger
      end
    end
  end

  describe "#log" do
    let(:log_stream) { StringIO.new }
    let(:label)      { "Cool Label" }

    before do
      subject.configure do |config|
        config.logger = ::Logger.new(log_stream)
        config.log_label = label
      end
    end

    context "when log is enabled" do
      it "logs the message" do
        subject.log "Some message to log."
        expect(log_stream.string).to include "[#{label}] Some message to log.\n"
      end

      it "calls log level method" do
        expect(subject.logger).to receive(:info).with("[#{label}] Some message to log.\n")
        subject.log "Some message to log."
      end
    end

    context "when log is disabled" do
      around do |example|
        subject.configure { |config| config.log_enabled = false }
        example.run
        subject.configure { |config| config.log_enabled = true }
      end

      it "does not log the message" do
        subject.log "Some message to log."
        expect(log_stream.string).to be_empty
      end
    end

    context "when log level is set" do
      around do |example|
        subject.configure { |config| config.log_level = :debug }
        example.run
        subject.configure { |config| config.log_level = :info }
      end

      it "calls log level set method" do
        expect(subject.logger).to receive(:debug).with("[#{label}] Some message to log.\n")
        subject.log "Some message to log."
      end
    end
  end
end
