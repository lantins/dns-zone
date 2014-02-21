# `MX` resource record.
#
# RFC 1035
class DNS::Zone::RR::MX < DNS::Zone::RR::Record

  attr_accessor :preference
  attr_accessor :exchange

  def dump
    parts = general_prefix
    parts << preference
    parts << exchange
    parts.join(' ')
  end

end
