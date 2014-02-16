class DNS::Zone::RR::NS < DNS::Zone::RR::Record

  attr_accessor :nameserver

  def to_s
    parts = generic_prefix
    parts << nameserver
    parts.join(' ')
  end

end
