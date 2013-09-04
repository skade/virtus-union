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
  end

end