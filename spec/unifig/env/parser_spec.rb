require 'tempfile'

RSpec.describe Unifig::Env::Parser do
  describe '.call' do
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

    it 'returns a hash representing the env vars loaded from the file' do
      result = described_class.call(file.path)

      expect(result).to be_an_instance_of(Hash)
      expect(result.keys.size).to be 4
      expect(result['ONE']).to eql '1'
      expect(result['TWO']).to eql '2'
      expect(result['THREE']).to eql '3'
      expect(result['MULTI_LINE']).to eql "\nfirst\nsecond\n"
    end
  end
end
