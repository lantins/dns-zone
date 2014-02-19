require './lib/dns/zone/version'

spec = Gem::Specification.new do |s|
  # gem information/details
  s.name                = 'dns-zone'
  s.version             = DNS::Zone::Version
  s.date                = Time.now.strftime('%Y-%m-%d')
  s.summary             = 'A Ruby library for building and parsing DNS zone files.'
  s.license             = 'MIT'
  s.homepage            = 'https://github.com/lantins/dns-zone'
  s.authors             = ['Luke Antins']
  s.email               = ['luke@lividpenguin.com']

  # gem settings for what files to include.
  s.files               = %w(Rakefile README.md HISTORY.md Gemfile Guardfile dns-zone.gemspec)
  s.files              += Dir.glob('{test/**/*,lib/**/*}')
  s.require_paths       = ['lib']
  #s.executables         = ['dns-zone']
  #s.default_executable  = 'dns-zone'

  # min ruby version
  s.required_ruby_version = ::Gem::Requirement.new("~> 1.9")

  # cross platform gem dependencies
  #s.add_dependency('gli')
  #s.add_dependency('paint')
  s.add_development_dependency('bundler',        '~> 1.0')
  s.add_development_dependency('rake',           '~> 10.0')
  s.add_development_dependency('minitest',       '~> 5.0')
  s.add_development_dependency('simplecov',      '~> 0.0')
  s.add_development_dependency('yard',           '~> 0.0')
  s.add_development_dependency('inch',           '~> 0.0')
  s.add_development_dependency('guard-minitest', '~> 2.0')
  s.add_development_dependency('guard-bundler',  '~> 0')

  # long description.
  s.description       = <<-EOL
A Ruby library for building and parsing DNS zone files for use with
Bind and PowerDNS (with Bind backend) DNS servers.
  EOL
end