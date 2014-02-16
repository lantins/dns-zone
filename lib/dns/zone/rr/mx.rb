class DNS::Zone::RR::MX < DNS::Zone::RR::Record

  attr_accessor :preference
  attr_accessor :exchange

  def to_s
    parts = generic_prefix
    parts << preference
    parts << exchange
    parts.join(' ')
  end

end
