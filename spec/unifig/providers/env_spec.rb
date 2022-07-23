RSpec.describe Unifig::Providers::Env do
  describe '.name' do
    it 'returns the provider name' do
      expect(described_class.name).to be :env
    end
  end

  describe '.retrieve' do
    before do
      allow(ENV).to receive(:[]).and_return(nil)
      allow(ENV).to receive(:[]).with('FOO').and_return('foo')
      allow(ENV).to receive(:[]).with('BAR').and_return('bar')
    end

    it 'returns a hash of only the available vars' do
      result = described_class.retrieve(%i[FOO BAR BAZ])

      expect(result).to be_an_instance_of(Hash)
      expect(result.keys.size).to be 2
      expect(result[:FOO]).to eql 'foo'
      expect(result[:BAR]).to eql 'bar'
    end
  end
end
