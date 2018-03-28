
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_struct/version'

Gem::Specification.new do |spec|
  spec.name          = 'data_struct'
  spec.version       = DataStruct::VERSION
  spec.authors       = ['Scott Nelson']
  spec.email         = ['snelson@barefootproximity.com']

  spec.summary       = 'Modification of RecursiveOpenStruct to allow traversal of object'
  spec.description   = 'The DataStruct class is used to load and store data/**/*.yml directories similar to Middleman.'
  spec.homepage      = 'https://github.com/BarefootProximity/data-struct'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.53.0'

  spec.add_runtime_dependency 'recursive-open-struct', '~> 1.1'
end
