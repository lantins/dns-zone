dns-zone
========

[![Build Status](https://secure.travis-ci.org/lantins/dns-zone.png?branch=master)](http://travis-ci.org/lantins/dns-zone)
[![Gem Version](https://badge.fury.io/rb/dns-zone.png)](http://badge.fury.io/rb/dns-zone)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/lantins/dns-zone/blob/master/LICENSE)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/lantins/dns-zone/master/frames)

A Ruby library for building and parsing DNS zone files.

## Installation

Add this line to your Gemfile:

    gem 'dns-zone'

And then execute:

    bundle install

Require the gem in your code:

    require 'dns/zone'

## Usage

### Loading a zone file

    zone = DNS::Zone.load(zone_as_string)

### Creating a new zone programmatically

    zone = DNS::Zone.new
    zone.origin = 'example.com.'
    zone.ttl = '1d'
    zone.soa.nameserver = 'ns0.lividpenguin.com.'
    zone.soa.email = 'hostmaster.lividpenguin.com.'

    # output as dns zone file
    zone.dump

# Development

## Development Commands

    # install external gem dependencies first
    bundle install

    # run all tests and build code coverage
    bundle exec rake test

    # hints where to improve docs
    bundle exec inch

    # watch for changes and run development commands (tests, documentation, etc)
    bundle exec guard

# TODO

## Must have

    [x] Ability to load a zone made of multiple RR's
    [x] Add support for RR Type: SOA
    [x] Add support for RR Type: NS
    [x] Add support for RR Type: MX
    [x] Add support for RR Type: AAAA
    [x] Add support for RR Type: A
    [x] Add support for RR Type: CNAME
    [x] Add support for RR Type: TXT
    [x] Add support for RR Type: SRV
    [x] Add support for RR Type: PTR
    [x] Add support for RR Type: SPF
    [x] Add support for RR Type: HINFO
    [x] Support loading zone where some records have an empty label

## Would be nice

    [ ] Handle parsing a zone file that uses more then one $ORIGIN directive.
    [ ] Basic validation, error checking:
        [ ] Only one SOA per zone.
        [ ] CNAMEs can't use a label of `@`.
        [ ] PTR zones have some extra conditions:
            [ ] labels cant be repeted
            [ ] names should end in a dot, otherwise they are invalid after expansion
            [ ] IPv4 and IPv6 cant be mixed

    [ ] Ability to 'include' defaults/records into a zone.
        This may or may not mean supporting the `$INCLUDE` directive.

## At some point; low priority

    [ ] Configuration options:
        [ ] spaces/tabs used between RR params in zone file output
        [ ] time format used in output (should parse both formats, seconds or bind time format (e.g. 1d))
            [ ] add comments to explain TTL's that are in seconds
    [ ] Ability to add comment to RR (n.b. currently we strip comments when parsing)
    [ ] Add support for RR Type: LOC (RFC 1876)
    [ ] Add support for RR Type: DNAME
    [ ] Add support for RR Type: DNSKEY
    [ ] Add support for RR Type: DS
    [ ] Add support for RR Type: KEY
    [ ] Add support for RR Type: NSEC
    [ ] Add support for RR Type: RRSIG
    [ ] Add support for RR Type: NAPTR
    [ ] Add support for RR Type: RP
    [ ] Add support for RR Type: RT

# Notes

- RR Format: `[<TTL>] [<class>] <type> <RDATA>`
- A DNS zone is built from RR's and a couple of other special directives.
- If zone file does not include $ORIGIN, it will be inferred by the `zone "<zone-name>" {}` clause from bind.conf
  In general we should always explicitly define an $ORIGIN directive unless there is a very good reason not to.
- [RFC 1035 - Domain Names - Implementation and Specification](http://www.ietf.org/rfc/rfc1035.txt)
- [RFC 2308 - Negative Caching of DNS Queries (DNS NCACHE)](http://www.ietf.org/rfc/rfc2308.txt)
- [RFC 3596 - DNS Extensions to Support IP Version 6](http://www.ietf.org/rfc/rfc3596.txt)
