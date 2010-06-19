# sysexits

Sysexits is a _completely awesome_ collection of human-readable constants for the standard (BSDish) exit codes, used as arguments to `Kernel.exit` to indicate a specific error condition to the parent process.

It's so fantastically fabulous that you'll want to fork it right away to avoid being thought of as that guy that's still using Webrick for his blog. I mean, `exit(1)` is so passé! This is like the 14-point font of Systems Programming.

Like the C header file from which this was derived (I mean forked, naturally), error numbers begin at `Sysexits::EX__BASE` (which is way more cool than plain old '64') to reduce the possibility of clashing with other exit statuses that other programs may already return.

The codes are available in two forms: as constants which can be imported into your own namespace via `include Sysexits`, or as `Sysexits::STATUS_CODES`, a Hash keyed by Symbols derived from the constant names.

Allow me to demonstrate. First, the old way:

    exit( 69 ) 

Whaaa...? Is that a euphemism? What's going on? See how unattractive and... well, 1970 that is? We're not changing vaccuum tubes here, people, we're _building a totally-awesome future in the Cloud™!_ 

    include Sysexits
    exit EX_UNAVAILABLE

Okay, at least this is readable to people who have used fork() more
than twice, but you could do so much better!

    include Sysexits
    exit :unavailable

Holy Toledo! It's like we're writing Ruby, but our own made-up
dialect in which variable++ is possible! Well, okay, it's not quite
that cool. But it does look more Rubyish. And no monkeys were patched
in the filming of this episode! All the simpletons still exiting
with icky *numbers* can still continue blithely along, none the
wiser.

## Contributing

You can check out the current development source with Mercurial like so:

    hg clone http://repo.deveiate.org/sysexits

You can submit bug reports, suggestions, and read more super-exited pointless marketing at:

    http://deveiate.org/sysexits.html

# License

See the included [LICENSE](LICENSE.html) file for licensing details.

