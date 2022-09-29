# frozen_string_literal: true

require 'strscan'

module Unifig
  module Env
    # @private
    module Parser
      Error = Class.new(Unifig::Error)

      WHITESPACE = /\s*/.freeze
      COMMENT = /\#.*$/.freeze
      EXPORT = /export\s+/.freeze
      KEY = /[^=\s]+/.freeze
      ASSIGNMENT = /\s*=\s*/.freeze
      SINGLE_LINE_VALUE = /\S+/.freeze
      QUOTE = /['"]/.freeze
      TO_END_OF_LINE = /\s*(?:\#.*)?$/.freeze

      class << self
        def call(file_path)
          content = File.read(file_path)

          vars = {}
          parser = StringScanner.new(content.strip)
          until parser.eos?
            parser.skip(WHITESPACE)

            next if parser.skip(COMMENT)

            parser.skip(EXPORT)
            key = extract!(parser, KEY, 'Missing env key on line %i')
            extract!(parser, ASSIGNMENT, 'Missing env var assignment on line %i')
            quote = parser.scan(QUOTE)
            value =
              if quote
                parser.scan(/.*?#{quote}/m).chop
              else
                parser.scan(SINGLE_LINE_VALUE)
              end

            extract!(parser, TO_END_OF_LINE, 'Invalid env var value on line %i')

            vars[key] = value
          end

          vars
        end

        private

        def line(parser)
          parser.string[0...parser.pos].scan(/$/).count
        end

        def extract!(parser, pattern, error_msg)
          parser.scan(pattern).tap do |match|
            raise Error, error_msg % line(parser) if match.nil?
          end
        end
      end
    end
  end
end
