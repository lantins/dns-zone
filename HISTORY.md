## HEAD

Development sponsored by Peter J. Philipp [centroid.eu](http://centroid.eu)

* Add support for DNSSEC focused RR Types:
    - NAPTR (RFC 3403)
    - SSHFP (RFC 4255)
    - DNSKEY (RFC 4034)
    - DS (RFC 4034)
    - RRSIG (RFC 4034)
    - CDNSKEY (RFC 7344)
    - CDS (RFC 7344)
    - DLV (RFC 4431)

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
