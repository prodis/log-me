# encoding: UTF-8
require 'spec_helper'

module FakeModule
  extend LogMe
end

describe LogMe do
  describe "#log_enabled?" do
    it "default is true" do
      FakeModule.log_enabled?.should be_true
    end

    context "when log is disabled" do
      around do |example|
        FakeModule.configure_me { |config| config.log_enabled = false }
        example.run
        FakeModule.configure_me { |config| config.log_enabled = true }
      end

      it "returns false" do
        FakeModule.log_enabled?.should be_false
      end
    end
  end

  describe "#log_level" do
    it "default is info" do
      FakeModule.log_level.should == :info
    end

    context "when log level is set" do
      around do |example|
        FakeModule.configure_me { |config| config.log_level = :debug }
        example.run
        FakeModule.configure_me { |config| config.log_level = :info }
      end

      it "returns set level" do
        FakeModule.log_level.should == :debug
      end
    end
  end

  describe "#logger" do
    it "default is Logger" do
      FakeModule.logger.should be_a(::Logger)
    end

    context "when set logger" do
      it "returns set logger" do
        fake_logger = Class.new
        FakeModule.configure_me { |config| config.logger = fake_logger }
        FakeModule.logger.should == fake_logger
      end
    end
  end

  describe "#log" do
    before :each do
      @log_stream = StringIO.new
      FakeModule.configure_me { |config| config.logger = ::Logger.new(@log_stream) }
    end

    context "when log is enabled" do
      it "logs the message" do
        FakeModule.log("Some message to log.")
        @log_stream.string.should include("Some message to log.")
      end

      it "calls log level method" do
        FakeModule.logger.should_receive(:info).with("Some message to log.")
        FakeModule.log("Some message to log.")
      end
    end

    context "when log is disabled" do
      around do |example|
        FakeModule.configure_me { |config| config.log_enabled = false }
        example.run
        FakeModule.configure_me { |config| config.log_enabled = true }
      end

      it "does not log the message" do
        FakeModule.log("Some message to log.")
        @log_stream.string.should be_empty
      end
    end

    context "when log level is set" do
      around do |example|
        FakeModule.configure_me { |config| config.log_level = :debug }
        example.run
        FakeModule.configure_me { |config| config.log_level = :info }
      end

      it "calls log level set method" do
        FakeModule.logger.should_receive(:debug).with("Some message to log.")
        FakeModule.log("Some message to log.")
      end
    end
  end
end
