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
          env_vars = Unifig::Env::Parser.call(config.fetch(:file, '.env'))

          var_names.to_h do |name|
            [name, env_vars[name.to_s]]
          end
        end
      end
    end
  end
end
