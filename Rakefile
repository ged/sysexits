#!/usr/bin/env rake
#encoding: utf-8

require 'hoe'

Hoe.plugin :deveiate
Hoe.plugin :mercurial
Hoe.plugin :signing

Hoe.plugins.delete :rubyforge

hoespec = Hoe.spec 'sysexits' do
	self.readme_file = 'README.rdoc'
	self.history_file = 'History.rdoc'
	self.extra_rdoc_files = FileList[ '*.rdoc' ]
	self.spec_extras[:rdoc_options] = ['-f', 'fivefish', '-t', 'Sysexits']

	self.developer 'Michael Granger', 'ged@FaerieMUD.org'

	self.dependency 'rspec', '~> 2.11', :developer
	self.dependency 'simplecov', '~> 0.6', :developer

	self.spec_extras[:licenses] = ["BSD"]
	self.spec_extras[:post_install_message] = %{
		Get ready to be amazed. I'll bet you can't wait to Exit Like 
		a Pro®!

		Well, if you want, you can do it right from the command-line! Check 
		this out:

		  ruby -rubygems -e \\
		    'require "sysexits"; include Sysexits; exit :software_error' \\
		    || echo $?

		I know, I know: so awesome right? Okay, I'll let you bask in the
		warn glow of superior systems-programming now.

	}.gsub( /^\t+/m, '' )

	self.require_ruby_version( '>=1.8.7' )
	self.hg_sign_tags = true if self.respond_to?( :hg_sign_tags )
	self.rdoc_locations << "deveiate:/usr/local/www/public/code/#{remote_rdoc_dir}"
end

ENV['VERSION'] ||= hoespec.spec.version.to_s

# Run the tests before checking in
task 'hg:precheckin' => [ :check_history, :check_manifest, :spec ]

# Rebuild the ChangeLog immediately before release
task :prerelease => 'ChangeLog'
CLOBBER.include( 'ChangeLog' )

desc "Build a coverage report"
task :coverage do
	ENV["COVERAGE"] = 'yes'
	Rake::Task[:spec].invoke
end

