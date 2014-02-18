require 'logger'

module LogMe
  attr_writer :log_enabled
  attr_writer :log_level
  attr_writer :logger

  def log_enabled?
    @log_enabled != false
  end

  def log_level
    @log_level ||= :info
  end

  def logger
    @logger ||= ::Logger.new STDOUT
  end

  def log(message)
    logger.send log_level, "#{message}\n" if log_enabled?
  end

  def self.extended(base)
    base.send :extend, Configuration
  end

  module Configuration
    def configure
      yield self if block_given?
    end
  end
end
