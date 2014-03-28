# `MX` resource record.
#
# RFC 1035
class DNS::Zone::RR::MX < DNS::Zone::RR::Record

  REGEX_MX_RDATA = %r{
    (?<priority>\d+)\s*
    (?<exchange>#{DNS::Zone::RR::REGEX_DOMAINNAME})\s*
  }mx

  attr_accessor :priority
  attr_accessor :exchange

  def dump
    parts = general_prefix
    parts << priority
    parts << exchange
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_MX_RDATA)
    return nil unless captures

    @priority = captures[:priority].to_i
    @exchange = captures[:exchange]
    self
  end

end
