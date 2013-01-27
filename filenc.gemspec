spec = Gem::Specification.new do |s|
  s.name = 'filenc'
  s.version = "0.0.1"
  s.authors = ["Virender Khatri"]
  s.date = '2013-01-27'
  s.platform = Gem::Platform::RUBY
  s.summary = 'File Encryption'
  s.description = "Ruby OpenSSL File Encrypt/Decrypt wrapper"
# Add your other files here if you make them
  s.files = ["README.md","COPYING","CONTRIBUTORS","CHANGELOG","bin/filenc","lib/filenc.rb"]
  s.require_paths << 'lib'
  s.add_dependency 'openssl'
  s.homepage = 'http://rubygems.org/gems/filenc'
end
