module Virtus
  class Attribute
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
        super
        options[:types] = type.types
        options[:discriminator] = type.discriminator
        options
      end

      # Coerce a given value to the correct type given in the
      # Union configuration. Return `nil` if unknown.
      #
      # @param [Object] value
      #
      # @return [Virtus] The coerced value.
      def coerce(value)
        type_tag = value[options[:discriminator]]
        type_tag = @union_attributes[:discriminator].coerce(type_tag)

        if attribute = @union_attributes[type_tag]
          attribute.coerce(value)
        else
          nil
        end
      end
    end
  end
end