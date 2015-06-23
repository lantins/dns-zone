# `DNSKEY` resource record.
#
# RFC 4034
class DNS::Zone::RR::DNSKEY < DNS::Zone::RR::Record

  REGEX_DNSKEY_RDATA = %r{
    (?<flags>\d+)\s*
    (?<protocol>\d+)\s*
    (?<algorithm>\d+)\s*
    (?<key>#{DNS::Zone::RR::REGEX_STRING})\s*
  }mx

  attr_accessor :flags, :protocol, :algorithm, :key

  def dump
    parts = general_prefix
    parts << flags
    parts << protocol
    parts << algorithm
    parts << key
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_DNSKEY_RDATA)
    return nil unless captures

    @flags = captures[:flags].to_i
    @protocol = captures[:protocol].to_i
    @algorithm = captures[:algorithm].to_i
    @key = captures[:key].scan(/#{DNS::Zone::RR::REGEX_STRING}/).join
    self
  end

end
