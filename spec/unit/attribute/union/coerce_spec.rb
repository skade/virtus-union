# encoding: utf-8

require 'spec_helper'

describe Virtus::Attribute::Union, '#coerce' do
  subject { object.coerce(value) }

  module Typed
    include Virtus

    attribute :type, String
  end

  class A
    include Typed

    attribute :a, String
  end

  class B
    include Typed

    attribute :b, String
  end

  let(:object)        { described_class.new(name, options)   }
  let(:discriminator) { :type                                 }
  let(:types)         { { a: A, b: B }                        }
  let(:options)       { { discriminator: discriminator, types: types }}
  let(:name)          { :union                                }

  context 'when the value has :type => :a' do
    let(:value)       { { type: :a, a: 'foo' }                }

    it { should be_kind_of(A) }
  end

  context 'when the value has :type => :b' do
    let(:value)       { { type: :b, b: 'bar' }                }

    it { should be_kind_of(B) }
  end

  context 'when the value has no known type' do
    let(:value)       { { type: :c, c: 'bar' }                }

    it { should be(nil) }
  end

  context 'when the value is a known type already' do
    let(:value)       { A.new                                 }

    it { should be(value) }
  end

  context 'without discriminator' do
    let(:options)     { { types: types } }
    let(:types)       { { 'Fixnum' => Fixnum }}
    let(:value)       { 1 }

    it { should be(value) }
  end
end