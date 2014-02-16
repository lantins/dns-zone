class DNS::Zone::RR::SRV < DNS::Zone::RR::Record

  attr_accessor :priority, :weight, :port, :target

  def to_s
    parts = generic_prefix
    parts << priority
    parts << weight
    parts << port
    parts << target
    parts.join(' ')
  end

end
