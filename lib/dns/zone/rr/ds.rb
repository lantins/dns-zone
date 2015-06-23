# `DS` resource record.
#
# RFC 4034
class DNS::Zone::RR::DS < DNS::Zone::RR::Record

  REGEX_DS_RDATA = %r{
    (?<key_tag>\d+)\s*
    (?<algorithm>\d+)\s*
    (?<digest_type>\d+)\s*
    (?<digest>#{DNS::Zone::RR::REGEX_STRING})\s*
  }mx

  attr_accessor :key_tag, :algorithm, :digest_type, :digest

  def dump
    parts = general_prefix
    parts << key_tag
    parts << algorithm
    parts << digest_type
    parts << digest
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_DS_RDATA)
    return nil unless captures

    @key_tag = captures[:key_tag].to_i
    @algorithm = captures[:algorithm].to_i
    @digest_type = captures[:digest_type].to_i
    @digest = captures[:digest].scan(/#{DNS::Zone::RR::REGEX_STRING}/).join
    self
  end

end
