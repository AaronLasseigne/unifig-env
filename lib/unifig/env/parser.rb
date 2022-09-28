# frozen_string_literal: true

require 'strscan'

module Unifig
  module Env
    # @private
    module Parser
      def self.call(file_path)
        content = File.read(file_path)

        vars = {}
        parser = StringScanner.new(content.strip)
        until parser.eos?
          parser.skip(/\s+/)

          next if parser.skip(/\#.*$/)

          parser.skip(/export\s+/)
          key = parser.scan(/[^=\s]+/)
          parser.skip(/\s*=\s*/)
          quote = parser.scan(/['"]/)
          value =
            if quote
              parser.scan(/.*?#{quote}/m).chop
            else
              parser.scan(/\S+/)
            end

          parser.skip(/.*$/)

          vars[key] = value
        end

        vars
      end
    end
  end
end
