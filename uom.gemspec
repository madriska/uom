# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{uom}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brad Ediger", "Gregory Brown"]
  s.date = %q{2009-02-17}
  s.description = %q{Ruby library for managing physical units of measure}
  s.email = %q{brad.ediger@madriska.com}
  s.files = ["README.markdown", "VERSION.yml", "lib/uom", "lib/uom/active_record.rb", "lib/uom/compound_unit.rb", "lib/uom/core_extensions.rb", "lib/uom/quantity.rb", "lib/uom/unit.rb", "lib/uom/unit_definitions.rb", "lib/uom.rb", "spec/uom_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/bradediger/uom}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby library for managing physical units of measure}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
