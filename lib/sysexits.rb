#!/usr/bin/env ruby

# sysexits.rb -- Exit status codes for system programs.
# $Id$
# 
# This file was derived almost entirely from the BSD sysexits.h, which
# is distributed under the following license:
#
#   Copyright (c) 1987, 1993
#     The Regents of the University of California.  All rights reserved.
#   
#   Redistribution and use in source and binary forms, with or without
#   modification, are permitted provided that the following conditions
#   are met:
#   1. Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#   3. All advertising materials mentioning features or use of this software
#      must display the following acknowledgement:
#     This product includes software developed by the University of
#     California, Berkeley and its contributors.
#   4. Neither the name of the University nor the names of its contributors
#      may be used to endorse or promote products derived from this software
#      without specific prior written permission.
#   
#   THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
#   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#   ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
#   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
#   OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
#   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#   LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
#   OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
#   SUCH DAMAGE.
#

# Sysexits is a completely awesome collection of human-readable
# constants for the standard (BSDish) exit codes, used as arguments
# to Kernel.exit() to indicate a specific error condition to the
# parent process.
# 
# It's so fantastically fabuluous that you'll want to fork it right
# away to avoid being thought of as that guy that's still using Webrick
# for his blog. I mean, exit(1) is so passé! This is like the 14-point
# font of Systems Programming.
# 
# Like the C header file from which this was derived (I mean forked,
# naturally), error numbers begin at Sysexits::EX__BASE (which is way
# more cool than plain old '64') to reduce the possibility of clashing
# with other exit statuses that other programs may already return.
# 
# The codes are available in two forms, as constants which can be
# imported into your own namespace via Kernel.include, or as a Hash
# keyed by a symbol derived from the constant name.
# 
# Allow me to demonstrate:
# 
#   exit( 69 ) 
# 
# Whaaa...? Is that a euphimism?
# 
#   include Sysexits
#   exit EX_UNAVAILABLE
# 
# Okay, at least this is readable to people who have used fork() more
# than twice, but you could do so much better!
# 
#   include Sysexits
#   exit :unavailable
#
# Holy Toledo! It's like we're writing Ruby, but our own made-up
# dialect in which variable++ is possible! Well, okay, it's not quite
# that cool. But it does look more Rubyish. And no monkeys were patched
# in the filming of this episode! All the simpletons still exiting
# with icky *numbers* can still continue blithely along, none the
# wiser.
# 
module Sysexits

	# The library version
	VERSION = '1.0.0'

	# The library's revision id
	REVISION = %q$Revision$


	# 
	# The constants
	# 

	# Successful termination
	EX_OK          = 0


	# The base value for sysexit codes
	EX__BASE       = 64

	# The command was used incorrectly, e.g., with the wrong number of
	# arguments, a bad flag, a bad syntax in a parameter, or whatever.
	EX_USAGE       = 64

	# The input data was incorrect in some way. This should only be used 
	# for user data, not system files.
	EX_DATAERR     = 65

	# An input file (not a system file) did not exist or was not readable.
	# This could also include errors like "No message" to a mailer (if
	# it cared to catch it).
	EX_NOINPUT     = 66

	# The user specified did not exist.  This might be used for mail
	# addresses or remote logins.
	EX_NOUSER      = 67

	# The host specified did not exist.  This is used in mail addresses
	# or network requests.
	EX_NOHOST      = 68

	# A service is unavailable.  This can occur if a support program or
	# file does not exist.  This can also be used as a catchall message
	# when something you wanted to do doesn't work, but you don't know
	# why.
	EX_UNAVAILABLE = 69

	# An internal software error has been detected. This should be limited
	# to non-operating system related errors.
	EX_SOFTWARE    = 70

	# An operating system error has been detected.  This is intended to
	# be used for such things as "cannot fork", "cannot create pipe", or
	# the like.  It includes things like getuid returning a user that
	# does not exist in the passwd file.
	EX_OSERR       = 71

	# Some system file (e.g., /etc/passwd, /etc/utmp, etc.) does not
	# exist, cannot be opened, or has some sort of error (e.g., syntax
	# error).
	EX_OSFILE      = 72

	# A (user specified) output file cannot be created.
	EX_CANTCREAT   = 73

	# An error occurred while doing I/O on a file.
	EX_IOERR       = 74

	# Temporary failure, indicating something that is not really a serious
	# error.  In sendmail, this means that a mailer (e.g.) could not
	# create a connection, and the request should be reattempted later.
	EX_TEMPFAIL    = 75

	# The remote system returned something that was "not possible" during
	# a protocol exchange.
	EX_PROTOCOL    = 76

	# You did not have sufficient permission to perform the operation.
	# This is not intended for file system problems, which should use
	# NOINPUT or CANTCREAT, but rather for higher level permissions.
	EX_NOPERM      = 77

	# There was an error in a user-specified configuration value.
	EX_CONFIG      = 78


	# The maximum listed value
	EX__MAX = constants.
		select {|name| name =~ /^EX_/ }.
		collect {|name| self.const_get(name) }.max


	# Mapping of human-readable Symbols to statuses
	STATUS_CODES = {
		#define EX_OK		0	/* successful termination */

		:_base                       => EX__BASE,

		:usage                       => EX_USAGE,

		:dataerr                     => EX_DATAERR,
		:data_error                  => EX_DATAERR,

		:noinput                     => EX_NOINPUT,
		:input_missing               => EX_NOINPUT,

		:nouser                      => EX_NOUSER,
		:no_such_user                => EX_NOUSER,

		:nohost                      => EX_NOHOST,
		:no_such_host                => EX_NOHOST,

		:unavailable                 => EX_UNAVAILABLE,
		:service_unavailable         => EX_UNAVAILABLE,

		:software                    => EX_SOFTWARE,
		:software_error              => EX_SOFTWARE,

		:oserr                       => EX_OSERR,
		:operating_system_error      => EX_OSERR,

		:osfile                      => EX_OSFILE,
		:operating_system_file_error => EX_OSFILE,

		:cantcreat                   => EX_CANTCREAT,
		:cant_create_output          => EX_CANTCREAT,

		:ioerr                       => EX_IOERR,

		:tempfail                    => EX_TEMPFAIL,
		:temporary_failure           => EX_TEMPFAIL,
		:try_again                   => EX_TEMPFAIL,

		:protocol                    => EX_PROTOCOL,
		:protocol_error              => EX_PROTOCOL,

		:noperm                      => EX_NOPERM,
		:permission_denied           => EX_NOPERM,

		:config                      => EX_CONFIG,
		:config_error                => EX_CONFIG,

		:_max                        => EX__MAX,

	}


	###############
	module_function
	###############

	### Enhanced exit! 
	def exit( status=EX_OK )
		status = case status
		         when Symbol, String
		         	STATUS_CODES[ status.to_sym ] or
		         		raise "unknown status %p" % [ status ]
		         else
		         	status
		         end

		Kernel.exit( status )
	end


end # module Sysexits

