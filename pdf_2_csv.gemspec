# -*- encoding: utf-8 -*-
require File.expand_path('../lib/pdf_2_csv/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anis Tayebali"]
  gem.email         = ["anis.tayebali@hyfn.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|spec|features)/})
  gem.name          = "pdf_2_csv"
  gem.require_paths = ["lib"]
  gem.version       = Pdf2Csv::VERSION
  gem.add_runtime_dependency "pdf-reader"

  gem.add_development_dependency "rspec"
end
