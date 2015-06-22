# `NAPTR` resource record.
#
# RFC 3403
class DNS::Zone::RR::NAPTR < DNS::Zone::RR::Record

  REGEX_NAPTR_RDATA = %r{
    (?<order>\d+)\s*
    (?<pref>\d+)\s*
    (?<flags>#{DNS::Zone::RR::REGEX_CHARACTER_STRING})\s*
    (?<service>#{DNS::Zone::RR::REGEX_CHARACTER_STRING})\s*
    (?<regexp>#{DNS::Zone::RR::REGEX_CHARACTER_STRING})\s*
    (?<replacement>#{DNS::Zone::RR::REGEX_DOMAINNAME}|\.{1})\s*
  }mx

  attr_accessor :order, :pref, :flags, :service, :regexp, :replacement

  def dump
    parts = general_prefix
    parts << order
    parts << pref
    parts << %Q{"#{flags}"}
    parts << %Q{"#{service}"}
    parts << %Q{"#{regexp}"}
    parts << replacement
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_NAPTR_RDATA)
    return nil unless captures

    @order = captures[:order].to_i
    @pref = captures[:pref].to_i
    @flags = captures[:flags].scan(/#{DNS::Zone::RR::REGEX_CHARACTER_STRING}/).join
    @service = captures[:service].scan(/#{DNS::Zone::RR::REGEX_CHARACTER_STRING}/).join
    @regexp = captures[:regexp].scan(/#{DNS::Zone::RR::REGEX_CHARACTER_STRING}/).join
    @replacement = captures[:replacement]
    self
  end

end
