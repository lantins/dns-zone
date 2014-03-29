# `SRV` resource record.
#
# RFC 2782
class DNS::Zone::RR::SRV < DNS::Zone::RR::Record

  REGEX_SRV_RDATA = %r{
    (?<priority>\d+)\s*
    (?<weight>\d+)\s*
    (?<port>\d+)\s*
    (?<target>#{DNS::Zone::RR::REGEX_DOMAINNAME})\s*
  }mx

  attr_accessor :priority, :weight, :port, :target

  def dump
    parts = general_prefix
    parts << priority
    parts << weight
    parts << port
    parts << target
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_SRV_RDATA)
    return nil unless captures

    @priority = captures[:priority].to_i
    @weight = captures[:weight].to_i
    @port = captures[:port].to_i
    @target = captures[:target]
    self
  end

end
