dns-zone
========

[![Build Status](https://secure.travis-ci.org/lantins/dns-zone.png?branch=master)](http://travis-ci.org/lantins/dns-zone)
[![Gem Version](https://badge.fury.io/rb/dns-zone.png)](http://badge.fury.io/rb/dns-zone)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/lantins/dns-zone/blob/master/LICENSE)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/lantins/dns-zone/master/frames)

A Ruby library for building, parsing and manipulating DNS zone files.

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
    
    # quick access to SOA RR
    zone.soa.nameserver = 'ns0.lividpenguin.com.'
    zone.soa.email = 'hostmaster.lividpenguin.com.'
    
    # add an A RR
    rec = DNS::Zone::RR::A.new
    rec.address = '127.0.0.1'
    zone.records << rec
    
    # output using dns zone file format
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

# Acknowledgement

Special thanks to Peter J. Philipp [centroid.eu](http://centroid.eu) for sponsoring the 0.2.0 release of dns-zone.

---

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

    [x] Add support for RR Type: NAPTR (RFC 3403)
    [x] Add support for RR Type: SSHFP (RFC 4255)

    [ ] Add test using real bind zone file, with DNSSEC RR's.
    [ ] Add support for DNSSEC (RFC 4034) RR Types:
        [x] DNSKEY
            [ ] Algorithm may be integer or mnemonic.
        [x] RRSIG
            [ ] Algorithm may be integer or mnemonic.
        [ ] NSEC
            [ ] Pay attention to Type Bit Maps field, especially when mnemonic is not known.
        [x] DS
    [ ] Add support for DNSSEC (RFC 5155) RR Types:
        [ ] NSEC3
        [ ] NSEC3PARAM

    [x] Add support for DNSSEC (RFC 4431 & RFC 7344) RR Types:
        [x] CDNSKEY (identical to DNSKEY)
        [x] CDS (identical to DS)
        [x] DLV (identical to DS)

## Would be nice

    [ ] Handle parsing a zone file that uses more then one $ORIGIN directive.
    [ ] Basic validation, error checking:
        [ ] Only one SOA per zone.
        [ ] CNAMEs can't use a label of `@`.
        [ ] PTR zones have some extra conditions:
            [ ] labels cant be repeated
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
    [ ] Add support for RR Type: DNAME (RFC 2672)
    [ ] Add support for RR Type: KEY
    [ ] Add support for RR Type: RP
    [ ] Add support for RR Type: RT

# Misc. Development Notes

- RR Format: `[<TTL>] [<class>] <type> <RDATA>`
- A DNS zone is built from RR's and a couple of other special directives.
- If zone file does not include $ORIGIN, it will be inferred by the `zone "<zone-name>" {}` clause from bind.conf
  In general we should always explicitly define an $ORIGIN directive unless there is a very good reason not to.
- [RFC 1035 - Domain Names - Implementation and Specification](http://www.ietf.org/rfc/rfc1035.txt)
- [RFC 2308 - Negative Caching of DNS Queries (DNS NCACHE)](http://www.ietf.org/rfc/rfc2308.txt)
- [RFC 3596 - DNS Extensions to Support IP Version 6](http://www.ietf.org/rfc/rfc3596.txt)
