module Virtus
  class Attribute
    class Union < EmbeddedValue
      primitive Virtus::Union

      def initialize(*)
        super
        @union_attributes = AttributeSet.new
        options[:types].each do |tag, type|
          @union_attributes << Attribute.build(tag, type)
        end
        @union_attributes << Attribute.build(:discriminator, Symbol)
      end

      def self.merge_options(type, options)
        options[:types] = type.types
        options[:discriminator] = type.discriminator
        options
      end

      def coerce(value)
        type_tag = value[options[:discriminator]]
        type_tag = @union_attributes[:discriminator].coerce(type_tag)
        @union_attributes[type_tag].coerce(value)
      end
    end
  end
end