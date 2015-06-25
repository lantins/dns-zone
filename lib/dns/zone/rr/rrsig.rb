# `RRSIG` resource record.
#
# RFC 4034
class DNS::Zone::RR::RRSIG < DNS::Zone::RR::Record

  REGEX_RRSIG_RDATA = %r{
    (?<type_covered>\S+)\s*
    (?<algorithm>\d+)\s*
    (?<labels>\d+)\s*
    (?<original_ttl>#{DNS::Zone::RR::REGEX_TTL})\s*
    (?<signature_expiration>\d+)\s*
    (?<signature_inception>\d+)\s*
    (?<key_tag>\d+)\s*
    (?<signer>#{DNS::Zone::RR::REGEX_DOMAINNAME})\s*
    (?<signature>#{DNS::Zone::RR::REGEX_CHARACTER_STRING})\s*
  }mx

  attr_accessor :type_covered, :algorithm, :labels, :original_ttl, :signature_expiration,
                :signature_inception, :key_tag, :signer, :signature

  def dump
    parts = general_prefix
    parts << type_covered
    parts << algorithm
    parts << labels
    parts << original_ttl
    parts << signature_expiration
    parts << signature_inception
    parts << key_tag
    parts << signer
    parts << signature
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_RRSIG_RDATA)
    return nil unless captures

    @type_covered = captures[:type_covered]
    @algorithm = captures[:algorithm].to_i
    @labels = captures[:labels].to_i
    @original_ttl = captures[:original_ttl].to_i
    @signature_expiration = captures[:signature_expiration].to_i
    @signature_inception = captures[:signature_inception].to_i
    @key_tag = captures[:key_tag].to_i
    @signer = captures[:signer]
    @signature = captures[:signature]
    self
  end

end
