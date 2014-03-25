# `SRV` resource record.
#
# RFC xxxx
class DNS::Zone::RR::SOA < DNS::Zone::RR::Record

  REGEX_SOA_RDATA = %r{
    (?<nameserver>#{DNS::Zone::RR::REGEX_DOMAINNAME})\s* # get nameserver domainname
    (?<email>#{DNS::Zone::RR::REGEX_DOMAINNAME})\s*      # get mailbox domainname
    (?<serial>\d+)\s*
    (?<refresh_ttl>#{DNS::Zone::RR::REGEX_TTL})\s*
    (?<retry_ttl>#{DNS::Zone::RR::REGEX_TTL})\s*
    (?<expiry_ttl>#{DNS::Zone::RR::REGEX_TTL})\s*
    (?<minimum_ttl>#{DNS::Zone::RR::REGEX_TTL})\s*
  }mx

  attr_accessor :nameserver, :email, :serial, :refresh_ttl, :retry_ttl, :expiry_ttl, :minimum_ttl

  def dump
    parts = general_prefix
    parts << nameserver
    parts << email

    parts << '('
    parts << serial
    parts << refresh_ttl
    parts << retry_ttl
    parts << expiry_ttl
    parts << minimum_ttl
    parts << ')'
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_SOA_RDATA)
    return nil unless captures

    @nameserver = captures[:nameserver]
    @email = captures[:email]
    @serial = captures[:serial].to_i
    @refresh_ttl = captures[:refresh_ttl]
    @retry_ttl = captures[:retry_ttl]
    @expiry_ttl = captures[:expiry_ttl]
    @minimum_ttl = captures[:minimum_ttl]

    self
  end

end
