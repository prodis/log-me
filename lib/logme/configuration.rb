# encoding: utf-8
module LogMe
  module Configuration
    def configure
      yield self if block_given?
    end
  end
end
