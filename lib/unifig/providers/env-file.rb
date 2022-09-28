# frozen_string_literal: true

module Unifig
  module Providers
    # @private
    module EnvFile
      class << self
        def name
          :'env-file'
        end

        def retrieve(var_names, config)
          env_vars = parse_file(config.fetch(:file, '.env'))

          var_names.to_h do |name|
            [name, env_vars[name.to_s]]
          end
        end

        private

        def parse_file(file_path)
          content = File.read(file_path)

          vars = {}
          parser = StringScanner.new(content)
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
end
