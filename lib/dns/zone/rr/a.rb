# `A` resource record.
#
# RFC 1035
class DNS::Zone::RR::A < DNS::Zone::RR::Record

  attr_accessor :address

  def dump
    parts = general_prefix
    parts << address
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata
    @address = rdata
    self
  end

end
