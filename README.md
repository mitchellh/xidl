# Ruby XIDL Parser

This is a library to parse XIDL (Extended Interface Definition Language)
files into usable Ruby objects. An eventual goal would also be to parse the
XIDL and create an API from it, but that is a longer term goal.

The only project I've ever seen actually use XIDL is [VirtualBox](http://virtualbox.org)
and in fact I am writing this parser to parse VirtualBox XIDL for my
[virtualbox](http://github.com/mitchellh/virtualbox) gem. But I do realize
that XIDL is an open format and other projects may use it, so I am open
sourcing this into a separate library.

## Installation

This library is distributed as a RubyGem:

    gem install xidl

