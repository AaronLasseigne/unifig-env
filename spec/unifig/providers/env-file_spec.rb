require 'tempfile'

RSpec.describe Unifig::Providers::EnvFile do
  describe '.name' do
    it 'returns the provider name' do
      expect(described_class.name).to be :'env-file'
    end
  end

  describe '.retrieve' do
    let(:file) do
      file = Tempfile.new('.env', Dir.pwd)
      file.write <<~ENV
        # standalone comment
        ONE=1
        export TWO=2
          THREE = 3 # in-line comment

        MULTI_LINE="
        first
        second
        "
      ENV
      file.close
      file
    end
    let(:config) { { file: file.path } }

    after do
      file.unlink
    end

    it 'returns a hash of only the available vars' do
      result = described_class.retrieve(%i[ONE TWO THREE MULTI_LINE INVALID], config)

      expect(result).to be_an_instance_of(Hash)
      expect(result.keys.size).to be 5
      expect(result[:ONE]).to eql '1'
      expect(result[:TWO]).to eql '2'
      expect(result[:THREE]).to eql '3'
      expect(result[:MULTI_LINE]).to eql "\nfirst\nsecond\n"
      expect(result[:INVALID]).to be_nil
    end
  end
end
