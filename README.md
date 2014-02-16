dns-zone
========

A Ruby library for building and parsing DNS zone files.

## Installation

Add this line to your Gemfile:

    gem 'dns-zone'

And then execute:

    bundle install

Require the gem in your code:

    require 'dns/zone'

## Usage

    DNS::Zone.new
    DNS::Zone.load(zone_as_string)
    DNS::Zone::RR.load(rr_as_string)
    DNS::Zone::RR::A.load(a_rr_as_string)

    zone = DNS::Zone.new
    zone.origin = 'example.com.'
    # FIXME: not sure what RFC (if any) defines the time formatting
    zone.ttl = '1d'
    # FIXME: keep DNS style representation? for <domain-name>s and email addresses
    zone.soa.nameserver = 'ns0.lividpenguin.com.'
    zone.soa.email = 'hostmaster.lividpenguin.com.'

    # output as dns zone file
    zone.to_zone_file

## Development Commands

    # install external gem dependencies first
    bundle install

    # run all tests and build code coverage
    bundle exec rake test

    # hints where to improve docs
    bundle exec inch

    # watch for changes and run development commands (tests, documentation, etc)
    bundle exec guard

## Notes

- RR Format: `[<TTL>] [<class>] <type> <RDATA>`
- A DNS zone is built from RR's and a couple of other special statements.
- [RFC 1035 - Domain Names - Implementation and Specification](http://www.ietf.org/rfc/rfc1035.txt)
- [RFC 3596 - DNS Extensions to Support IP Version 6](http://www.ietf.org/rfc/rfc3596.txt)
