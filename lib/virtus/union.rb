require "virtus"
require "virtus/union/version"
require "virtus/attribute/union"

module Virtus
  # Proxy type to define a Union virtus attribute.
  #
  # @example
  #   class MyClass
  #     include Virtus
  #     attribute :union, Union[:type, AVirtusType, AnotherVirtusType]
  #   end
  class Union
    include Enumerable

    # The types used in this union.
    attr_accessor :types
    # The discriminator attribute name.
    attr_accessor :discriminator

    # Constructs a new `Virtus::Union` object, holding a
    # discriminator value and the types used in this union.
    #
    # @param [Symbol] discrimitator The key used to detect the
    # object type.
    # @param [Hash<Symbol,Virtus>] types The types allowed in this
    # union, keyed by the discriminator value.
    def initialize(discriminator, types)
      self.discriminator = discriminator
      self.types = types
    end

    # Sugar method to construct a `Virtus::Union` object.
    #
    # @see #initialize
    #
    # @param [Symbol] discrimitator The key used to detect the object type.
    # @param [Hash<Symbol,Virtus>] types The types allowed in this union, keyed by the discriminator value.
    #
    # @return [Virtus::Union]
    def self.[](discrimitator, types)
      new(discrimitator, types)
    end

    # Iterates over all members of `types`.
    #
    # @return [Hash<Symbol,Virtus>]
    def each(&block)
      types.each(&block)
    end
  end
end
