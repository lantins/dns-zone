# `SSHFP` resource record.
#
# RFC 4255
class DNS::Zone::RR::SSHFP < DNS::Zone::RR::Record

  REGEX_SSHFP_RDATA = %r{
    (?<algorithm_number>\d+)\s*
    (?<fingerprint_type>\d+)\s*
    (?<fingerprint>#{DNS::Zone::RR::REGEX_STRING})\s*
  }mx

  attr_accessor :algorithm_number, :fingerprint_type, :fingerprint

  def dump
    parts = general_prefix
    parts << algorithm_number
    parts << fingerprint_type
    parts << fingerprint
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_SSHFP_RDATA)
    return nil unless captures

    @algorithm_number = captures[:algorithm_number].to_i
    @fingerprint_type = captures[:fingerprint_type].to_i
    @fingerprint = captures[:fingerprint]
    self
  end

end
