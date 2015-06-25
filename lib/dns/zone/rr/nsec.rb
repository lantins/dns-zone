# `NSEC` resource record.
#
# RFC 4034
class DNS::Zone::RR::NSEC < DNS::Zone::RR::Record

  REGEX_NSEC_RDATA = %r{
    (?<next_domain>#{DNS::Zone::RR::REGEX_DOMAINNAME})\s*
    (?<rrset_types>#{DNS::Zone::RR::REGEX_STRING})\s*
  }mx

  attr_accessor :next_domain, :rrset_types

  def dump
    parts = general_prefix
    parts << next_domain
    parts << rrset_types
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_NSEC_RDATA)
    return nil unless captures

    @next_domain = captures[:next_domain]
    @rrset_types = captures[:rrset_types]
    self
  end

end
