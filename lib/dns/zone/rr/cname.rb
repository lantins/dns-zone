class DNS::Zone::RR::CNAME < DNS::Zone::RR::Record

  attr_accessor :domainname

  def to_s
    parts = generic_prefix
    parts << domainname
    parts.join(' ')
  end

end
