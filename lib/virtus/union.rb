# encoding: utf-8

require 'virtus'
require 'virtus/union/version'
require 'virtus/attribute/union'

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

    # Constructs a new `Virtus::Union` object, holding a
    # discriminator value and the types used in this union.
    #
    # @param [Symbol] discrimitator The key used to detect the object type.
    # @param [Array<Class>] classes A list of classes to allow in this union
    # @param [Hash<Symbol,Virtus>] types The types allowed in this
    #   union, keyed by the discriminator value.
    #
    # @return [Virtus::Union]
    def initialize(*discriminator_and_types)
      extract_discriminator(discriminator_and_types)
      compile_type_list(discriminator_and_types)
    end

    # Sugar method to construct a `Virtus::Union` object.
    #
    # @see #initialize
    #
    # @return [Virtus::Union]
    def self.[](*args)
      new(*args)
    end

    # The compiled list of options for this union type.
    #
    # @return Hash[Symbol => Object]
    def options
      { discriminator: @discriminator, types: @types }
    end

    private
      # Extract the discriminator from the argument list.
      # Every leading symbol is considered the discriminator.
      #
      # @return [undefined]
      def extract_discriminator(discriminator_and_types)
        if Symbol === discriminator_and_types.first
          @discriminator = discriminator_and_types.shift
        end
      end

      # Compile the type list from the rest of the argument list.
      # This assumes the discriminator to be extracted already.
      #
      # @return Hash[Symbol => Class]
      def compile_type_list(types)
        if Hash === types.last
          @types = types.pop
        end

        transform_simple_types(types)
      end

      # Transform the list of simple types to a Hash keyed by their class name.
      #
      # @return Hash[Symbol => Class]
      def transform_simple_types(types)
        @types ||= {}
        types.each do |type|
          @types[type.name.to_sym] = type
        end
      end
  end
end
