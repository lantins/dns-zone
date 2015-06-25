# `NSEC3` resource record.
#
# RFC 5155
class DNS::Zone::RR::NSEC3 < DNS::Zone::RR::Record

  REGEX_NSEC3_RDATA = %r{
    (?<algorithm>\d+)\s*
    (?<flags>\d+)\s*
    (?<iterations>\d+)\s*
    (?<salt>\S+)\s*
    (?<next_hashed_owner_name>\S+)\s*
    (?<rrset_types>#{DNS::Zone::RR::REGEX_STRING})\s*
  }mx


  attr_accessor :algorithm, :flags, :iterations, :salt,
                :next_hashed_owner_name, :rrset_types

  def dump
    parts = general_prefix
    parts << algorithm
    parts << flags
    parts << iterations
    parts << salt
    parts << next_hashed_owner_name
    parts << rrset_types
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_NSEC3_RDATA)
    return nil unless captures

    @algorithm = captures[:algorithm].to_i
    @flags = captures[:flags].to_i
    @iterations = captures[:iterations].to_i
    @salt = captures[:salt]
    @next_hashed_owner_name = captures[:next_hashed_owner_name]
    @rrset_types = captures[:rrset_types]
    self
  end

end
