## HEAD

Development sponsored by Peter J. Philipp [centroid.eu](http://centroid.eu)

* Add support for DNSSEC focused RR Types:
    - RFC 3403: NAPTR
    - RFC 4255: SSHFP
    - RFC 4034: DNSKEY, DS, RRSIG, NSEC
    - RFC 7344: CDNSKEY, CDS
    - RFC 4431: DLV
    - RFC 5155: NSEC3, NSEC3PARAM
* Allow unqualified `domain-name` labels.
* Allow `ORIGIN` to be specified as an optional parameter when loading a zone, e.g. `zone = DNS::Zone.load(zone_as_string, 'example.com.')`

# 0.1.4 (no gem release)

* Add helper method to quickly access (or create) SOA.
* Add `dump_pretty` method to `DNS::Zone`.

## 0.1.3 (2014-10-21)

* Fix TXT record parsing bug, when quote enclosed RDATA contained semicolons.

## 0.1.1 (2014-03-30)

* Remove `required_ruby_version` from gemspec.

## 0.1.0 (2014-03-30)

* Initial non-alpha release with support for common resource records.

## 0.0.0 (2014-02-16)

* Initial development/hacking initiated.
