Gem::Specification.new do |s|
  s.name              = "integrity-email"
  s.version           = "1.0.1"
  s.date              = "2008-11-16"
  s.summary           = "Email notifier for the Integrity continuous integration server"
  s.description       = "Easily let Integrity send emails after each build"
  s.homepage          = "http://integrityapp.com"
  s.email             = "contacto@nicolassanguinetti.info"
  s.authors           = ["Nicolás Sanguinetti"]
  s.has_rdoc          = false

  s.add_dependency "integrity"
  s.add_dependency "sinatra-ditties", [">= 0.0.2"]

  s.files             = %w[
README.markdown
Rakefile
integrity-email.gemspec
lib/integrity/notifier/config.haml
lib/integrity/notifier/email.rb
test/mail_test.rb
]
end
