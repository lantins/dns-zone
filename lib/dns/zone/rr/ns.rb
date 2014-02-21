# `NS` resource record.
#
# RFC 1035
class DNS::Zone::RR::NS < DNS::Zone::RR::Record

  attr_accessor :nameserver

  def dump
    parts = general_prefix
    parts << nameserver
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata
    @nameserver = rdata
    self
  end

end
