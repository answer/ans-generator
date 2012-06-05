# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ans-generator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["sakai shunsuke"]
  gem.email         = ["sakai@ans-web.co.jp"]
  gem.description   = %q{rails3 用 view, rspec, feature の雛形を追加する}
  gem.summary       = %q{view, rspec, feature テンプレートの追加、差し替え}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ans-generator"
  gem.require_paths = ["lib"]
  gem.version       = Ans::Generator::VERSION

  gem.add_development_dependency "ans-releaser"
  gem.add_development_dependency "shoulda-matchers"
  gem.add_development_dependency "ans-matchers"
end
