require 'spec_helper'

describe Virtus::Union, "[]" do
  subject { object }

  let(:object)        { described_class[discriminator, types] }
  let(:discriminator) { :type                                }
  let(:types)         { {}                                   }

  it { should be_kind_of(described_class) }

  context "types" do
    subject { object.types }

    it { should be_equal(types) }
  end

  context "discriminator" do
    subject { object.discriminator }

    it { should be_equal(discriminator) }
  end
end