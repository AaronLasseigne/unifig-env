RSpec.describe Unifig::Providers::Env do
  describe '.name' do
    it 'returns the provider name' do
      expect(described_class.name).to be :env
    end
  end

  describe '.retrieve' do
    before do
      allow(ENV).to receive(:[]).and_return(nil)
      allow(ENV).to receive(:[]).with('ONE').and_return('1')
      allow(ENV).to receive(:[]).with('TWO').and_return('2')
    end

    it 'returns a hash of only the available vars' do
      result = described_class.retrieve(%i[ONE TWO INVALID], {})

      expect(result).to be_an_instance_of(Hash)
      expect(result.keys.size).to be 3
      expect(result[:ONE]).to eql '1'
      expect(result[:TWO]).to eql '2'
      expect(result[:INVALID]).to be_nil
    end
  end
end
