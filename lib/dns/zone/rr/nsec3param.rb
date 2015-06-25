# `NSEC3PARAM` resource record.
#
# RFC 5155
class DNS::Zone::RR::NSEC3PARAM < DNS::Zone::RR::Record

  REGEX_NSEC3PARAM_RDATA = %r{
    (?<algorithm>\d+)\s*
    (?<flags>\d+)\s*
    (?<iterations>\d+)\s*
    (?<salt>\S+)\s*
  }mx

  attr_accessor :algorithm, :flags, :iterations, :salt

  def dump
    parts = general_prefix
    parts << algorithm
    parts << flags
    parts << iterations
    parts << salt
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_NSEC3PARAM_RDATA)
    return nil unless captures

    @algorithm = captures[:algorithm].to_i
    @flags = captures[:flags].to_i
    @iterations = captures[:iterations].to_i
    @salt = captures[:salt]
    self
  end

end
