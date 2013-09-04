# encoding: utf-8

module Virtus
  # Abstract class implementing base API for attribute types
  #
  # @abstract
  class Attribute
    # Implements a Union attribute type, covering multiple EmbeddedValues
    #
    # @see Virtus::Union
    # @api private
    class Union < EmbeddedValue
      primitive Virtus::Union

      # Init an instance of Virtus::Attribute::Union
      #
      # @api private
      def initialize(*)
        super
        @union_attributes = AttributeSet.new
        options[:types].each do |tag, type|
          @union_attributes << Attribute.build(tag, type)
        end
        @union_attributes << Attribute.build(:discriminator, Symbol)
      end

      # Reads types and discriminator values from the configuration
      # type.
      #
      # @param [Virtus::Union]
      #
      # @param [Hash]
      #
      # @return [Hash]
      #
      # @api private
      def self.merge_options(type, options)
        options.merge type.options
        super
      end

      # Coerce a given value to the correct type given in the
      # Union configuration. Return `nil` if unknown.
      #
      # @param [Object] value
      #
      # @return [Virtus] The coerced value.
      def coerce(value)
        attribute = fetch_union_attribute(value)

        if attribute
          attribute.coerce(value)
        end
      end

      private
        def fetch_union_attribute(value)
          @union_attributes[fetch_type_tag(value)]
        end

        def fetch_type_tag(value)
          type_tag = value[options[:discriminator]]
          @union_attributes[:discriminator].coerce(type_tag)
        end
    end
  end
end