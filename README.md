# [Unifig::Env][]

Adds a provider to support loading environment variables to [Unifig][].

[![Version](https://img.shields.io/gem/v/unifig-env.svg?style=flat-square)](https://rubygems.org/gems/unifig-env)
[![Test](https://img.shields.io/github/workflow/status/AaronLasseigne/unifig-env/Test?label=Test&style=flat-square)](https://github.com/AaronLasseigne/unifig-env/actions?query=workflow%3ATest)

## Installation

Add it to your Gemfile:

``` rb
gem 'unifig-env', '~> 0.1.0'
```

Or install it manually:

``` sh
$ gem install unifig-env --version '~> 0.1.0'
```

This project uses [Semantic Versioning][].
Check out [GitHub releases][] for a detailed list of changes.

## Usage

Use `env` as your provider or add it to your list of providers:

``` yml
config:
  providers: env

HOST:
```

This will pull `"HOST"` from `ENV` and add it to Unifig.

## Contributing

If you want to contribute to Unifig:Env, please read [our contribution guidelines][].
A [complete list of contributors][] is available on GitHub.

## License

Unifig is licensed under [the MIT License][].

[Unifig::Env]: https://github.com/AaronLasseigne/unifig-env
[Unifig]: https://github.com/AaronLasseigne/unifig
[Semantic Versioning]: http://semver.org/spec/v2.0.0.html
[GitHub releases]: https://github.com/AaronLasseigne/unifig-env/releases
[our contribution guidelines]: CONTRIBUTING.md
[complete list of contributors]: https://github.com/AaronLasseigne/unifig-env/graphs/contributors
[the MIT License]: LICENSE.txt
