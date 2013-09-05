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
        @discriminator = Attribute.build(:discriminator, Symbol)
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
        return value if union_type?(value)
        coerce_using_attribute(value)
      end

      private
        # Get the union attribute matching by discriminator.
        #
        # @param [Object] value
        #
        # @return [Virtus::Attribute]
        def fetch_union_attribute(value)
          @union_attributes[fetch_discriminator_value(value)]
        end

        # Fetch the value of the discriminator field for a given value.
        #
        # @param [Object] value
        #
        # @return [Object] discriminator value
        def fetch_discriminator_value(value)
          discriminator_value = value[options[:discriminator]]
          @discriminator.coerce(discriminator_value)
        end

        # Predicate to check whether the value is already one of
        # the types allowed in this union.
        #
        # @param [Object] value
        #
        # @return [true|false]
        def union_type?(value)
          @union_attributes.any? do |attribute|
            value.class <= attribute.options[:primitive]
          end
        end

        # Coerce the value using one of the internal type attributes.
        #
        # @param [Object] value The value to coerce.
        #
        # @return [Object] The coerced value
        def coerce_using_attribute(value)
          attribute = fetch_union_attribute(value)

          if attribute
            attribute.coerce(value)
          end
        end
    end
  end
end