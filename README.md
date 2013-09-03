# Virtus::Union

A union type implementation for Virtus, working with embedded values.

## Installation

Add this line to your application's Gemfile:

    gem 'virtus-union'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install virtus-union

## Usage

`virtus-union` adds an additional `EmbeddedValue` subtype to virtus to cover unions. Usage:

```ruby
class SimpleOption
  include Virtus

  attribute :type, String, :default => :simple
  attribute :key, String
  attribute :value, String
end

class ComplexOption
  include Virtus

  attribute :type, String, :default => :complex
  attribute :key, String
  attribute :value, Hash
end

class Configurable
  include Virtus

  attribute :option, Union[:type, :simple => SimpleOption, :complex => ComplexOption]
  attribute :options_in_an_array, Array[Union[:type, :simple => SimpleOption, :complex => ComplexOption]]
end
```

A union tries do detect the actual type by looking at the `discriminator` field given as the first argument and picking the matching type using the type-map given as the second argument.

```ruby
Configurable.new(
  :option => {:type => "simple", :value => "Foobar"}
  :options_in_an_array => [{:type => "complex", :value => {:max => 100}}]
)
```

Be aware that the `type` attribute is not automatically generated.

## Missing

This only works for proper embedded values. Any suggestions for things like:

```ruby
Union[String, Integer]
```

Are accepted.

## Missing, but not missed

Automatic generation of type keys, e.g. `FooBarClass` => `foo_bar_class`. I prefer the explicit option.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
