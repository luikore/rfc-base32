Gem::Specification.new do |s|
  s.name = "rfc-base32"
  s.version = "0.1"
  s.author = "luikore"
  s.homepage = "http://github.com/luikore/rfc-base32"
  s.platform = Gem::Platform::RUBY
  s.summary = "RFC4648 Base32 Encode / Decode"
  s.required_ruby_version = ">=1.9.0"

  s.files = %w[src src/rfc4648 src/rfc4648/base32.rb]
  s.require_paths = ["lib"]
  s.rubygems_version = '1.3.7'
  #s.has_rdoc = true
  #s.extra_rdoc_files = ["README.rdoc"]
end


