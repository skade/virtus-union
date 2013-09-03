require "virtus"
require "virtus/union/version"
require "virtus/attribute/union"

module Virtus
  class Union
    include Enumerable

    attr_accessor :types, :discriminator

    def initialize(discriminator, types)
      self.discriminator = discriminator
      self.types = types
    end

    def self.[](discrimitator, types)
      new(discrimitator, types)
    end

    def each
      types.each
    end
  end
end
