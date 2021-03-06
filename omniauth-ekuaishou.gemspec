require_relative 'lib/omniauth-ekuaishou/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-ekuaishou"
  spec.version       = OmniAuth::Ekuaishou::VERSION
  spec.authors       = ["jimcheung"]
  spec.email         = ["hi.jinhu.zhang@gmail.com"]

  spec.summary       = %q{Omniauth strategy for Kuaishou Marketing}
  spec.description   = %q{Wrapper the Kuaishou Marketing Oauth2 API}
  spec.homepage      = "https://github.com/jinhucheung/omniauth-ekuaishou"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jinhucheung/omniauth-ekuaishou"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 2.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.7.1'
end
