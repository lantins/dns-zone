# `PTR` resource record.
#
# RFC 1035
class DNS::Zone::RR::PTR < DNS::Zone::RR::Record

  attr_accessor :name

  def dump
    parts = general_prefix
    parts << @name
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata
    @name = rdata
    self
  end

end
