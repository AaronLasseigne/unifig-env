# frozen_string_literal: true

require_relative 'lib/unifig/env/version'

Gem::Specification.new do |spec|
  spec.name = 'unifig-env'
  spec.version = Unifig::Env::VERSION
  spec.license = 'MIT'

  spec.authors = ['Aaron Lasseigne']
  spec.email = ['aaron.lasseigne@gmail.com']

  spec.summary = 'Adds a provider to support loading environment variables to Unifig.'
  spec.description = spec.summary
  spec.homepage = 'https://github.com/AaronLasseigne/unifig-env'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.required_ruby_version = '>= 2.7.0'

  spec.files =
    %w[CHANGELOG.md CONTRIBUTING.md LICENSE.txt README.md] +
    Dir.glob(File.join('lib', '**', '*.rb'))
  spec.test_files = Dir.glob(File.join('spec', '**', '*.rb'))

  spec.add_dependency 'unifig', '~> 0.1.0'
end
