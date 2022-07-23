# frozen_string_literal: true

module Unifig
  module Providers
    # @private
    module Env
      def self.name
        :env
      end

      def self.retrieve(var_names)
        env_values = var_names.to_h do |name|
          [name, ::ENV[name.to_s]]
        end
        env_values.compact!
        env_values
      end
    end
  end
end
