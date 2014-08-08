#!/usr/bin/env rake
#encoding: utf-8

require 'hoe'

Hoe.plugin :mercurial
Hoe.plugin :yard
Hoe.plugin :signing

Hoe.plugins.delete :rubyforge

hoespec = Hoe.spec 'sysexits' do
	self.readme_file = 'README.md'

	self.developer 'Michael Granger', 'ged@FaerieMUD.org'

	self.extra_dev_deps <<
		['rspec', '~> 2.1.0']

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
		warm glow of superior systems-programming now.

	}.gsub( /^\t+/m, '' )

	self.spec_extras[:signing_key] = '/Volumes/Keys/ged-private_gem_key.pem'

	self.require_ruby_version( '>=1.8.7' )
	self.hg_sign_tags = true if self.respond_to?( :hg_sign_tags )

	self.yard_opts = [ '--use-cache', '--protected', '--verbose' ]
	self.rdoc_locations << "deveiate:/usr/local/www/public/code/#{remote_rdoc_dir}"
end

ENV['VERSION'] ||= hoespec.spec.version.to_s

begin
	include Hoe::MercurialHelpers

	### Task: prerelease
	desc "Append the package build number to package versions"
	task :pre do
		rev = get_numeric_rev()
		trace "Current rev is: %p" % [ rev ]
		hoespec.spec.version.version << "pre#{rev}"
		Rake::Task[:gem].clear

		Gem::PackageTask.new( hoespec.spec ) do |pkg|
			pkg.need_zip = true
			pkg.need_tar = true
		end
	end

	### Make the ChangeLog update if the repo has changed since it was last built
	file '.hg/branch'
	file 'ChangeLog' => '.hg/branch' do |task|
		$stderr.puts "Updating the changelog..."
		content = make_changelog()
		File.open( task.name, 'w', 0644 ) do |fh|
			fh.print( content )
		end
	end

	# Rebuild the ChangeLog immediately before release
	task :prerelease => 'ChangeLog'

rescue NameError => err
	task :no_hg_helpers do
		fail "Couldn't define the :pre task: %s: %s" % [ err.class.name, err.message ]
	end

	task :pre => :no_hg_helpers
	task 'ChangeLog' => :no_hg_helpers

end

