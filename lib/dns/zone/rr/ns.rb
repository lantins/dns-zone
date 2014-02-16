# `NS` resource record.
#
# RFC 1035
class DNS::Zone::RR::NS < DNS::Zone::RR::Record

  attr_accessor :nameserver

  def to_s
    parts = general_prefix
    parts << nameserver
    parts.join(' ')
  end

end
