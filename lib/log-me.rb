# encoding: utf-8
require 'logger'
require 'logme/configuration'
require 'logme/http_formatter'

module LogMe
  attr_writer :log_enabled
  attr_writer :log_level
  attr_writer :log_label
  attr_writer :logger

  def log_enabled?
    @log_enabled != false
  end

  def log_level
    @log_level ||= :info
  end

  def log_label
    @log_label ||= self.name
  end

  def logger
    @logger ||= ::Logger.new(STDOUT)
  end

  def log(message)
    logger.send(log_level, "[#{log_label}] #{message}") if log_enabled?
  end

  def log_request(request, url)
    log formatter.format_request(request, url)
  end

  def log_response(response)
    log formatter.format_response(response)
  end

  def self.extended(base)
    base.send(:extend, LogMe::Configuration)
  end

  private

  def formatter
    @formatter ||= LogMe::HttpFormatter.new
  end
end
