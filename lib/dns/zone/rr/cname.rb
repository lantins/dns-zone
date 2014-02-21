# `CNAME` resource record.
#
# RFC 1035
class DNS::Zone::RR::CNAME < DNS::Zone::RR::Record

  attr_accessor :domainname

  def dump
    parts = general_prefix
    parts << domainname
    parts.join(' ')
  end

end
