# encoding: utf-8

require 'spec_helper'

describe Virtus::Union, '[]' do
  subject { object }

  let(:object)        { described_class[discriminator, types]          }
  let(:discriminator) { :type                                          }
  let(:types)         { {}                                             }
  let(:options)       { { discriminator: discriminator, types: types } }

  it { should be_kind_of(described_class) }

  context 'options' do
    subject { object.options }

    it { should eq(options) }

    context 'without discriminator' do
      let(:object)     { described_class[types]                           }
      let(:options)    { { discriminator: nil, types: types }             }

      it { should eq(options) }
    end

    context 'with simple types' do
      let(:object)     { described_class[*types]                          }
      let(:types)      { [Fixnum, String]                                 }
      let(:options)    do
        { discriminator: nil, types: { Fixnum: Fixnum, String: String } }
      end

      it { should eq(options) }
    end

    context 'with mixed types' do
      let(:object)     { described_class[*types]                          }
      let(:types)      { [Fixnum, String, { complex: complex }]           }
      let(:options)    do
        { discriminator: nil, types: {
            Fixnum: Fixnum, String: String, complex: complex } }
      end
      let(:complex)    { double('complex') }

      it { should eq(options) }
    end
  end

end