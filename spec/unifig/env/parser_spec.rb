require 'tempfile'

RSpec.describe Unifig::Env::Parser do
  describe '.call' do
    let(:file_content) do
      <<~ENV
        # standalone comment
        ONE=1
        export TWO=2
          THREE = 3 # in-line comment

        MULTI_LINE="
        first
        second
        "
      ENV
    end
    let(:file) do
      file = Tempfile.new('.env', Dir.pwd)
      file.write(file_content)
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

    context 'with a missing key' do
      let(:file_content) { '=1' }

      it 'throws an error' do
        expect do
          described_class.call(file.path)
        end.to raise_error Unifig::Env::Parser::Error, 'Missing env key on line 1'
      end
    end

    context 'with no equal sign' do
      let(:file_content) { 'ONE' }

      it 'throws an error' do
        expect do
          described_class.call(file.path)
        end.to raise_error Unifig::Env::Parser::Error, 'Missing env var assignment on line 1'
      end
    end

    context 'with an invalid value' do
      let(:file_content) { 'ONE=1 2' }

      it 'throws an error' do
        expect do
          described_class.call(file.path)
        end.to raise_error Unifig::Env::Parser::Error, 'Invalid env var value on line 1'
      end
    end

    context 'an error later in the file' do
      let(:file_content) do
        <<~ENV
          ONE=1
          TWO=2

          FOUR=4 invalid
          FIVE=5
        ENV
      end

      it 'puts the correct line' do
        expect do
          described_class.call(file.path)
        end.to raise_error Unifig::Env::Parser::Error, 'Invalid env var value on line 4'
      end
    end
  end
end
