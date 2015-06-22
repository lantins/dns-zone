# `HINFO` resource record.
#
# RFC 1035
class DNS::Zone::RR::HINFO < DNS::Zone::RR::Record

  REGEX_HINFO_RDATA = %r{
    (?<cpu>(?:#{DNS::Zone::RR::REGEX_CHARACTER_STRING})){1}\s
    (?<os>(?:#{DNS::Zone::RR::REGEX_CHARACTER_STRING})){1}
  }mx
  attr_accessor :cpu
  attr_accessor :os

  def dump
    parts = general_prefix
    parts << %Q{"#{cpu}" "#{os}"}
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_HINFO_RDATA)
    return nil unless captures

    @cpu = captures[:cpu].scan(/#{DNS::Zone::RR::REGEX_CHARACTER_STRING}/).join
    @os = captures[:os].scan(/#{DNS::Zone::RR::REGEX_CHARACTER_STRING}/).join
    self
  end

end
