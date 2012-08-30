# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ganglia-gearman/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nathan L Smith"]
  gem.email         = ["nlloyds@gmail.com"]
  gem.description   = %q{Check gearmand metrics and send them to Ganglia.}
  gem.summary       = %q{Connect to a running gearman server and send information about its status to Ganglia.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ganglia-gearman"
  gem.require_paths = ["lib"]
  gem.version       = Ganglia::Gearman::VERSION
end
