# `SRV` resource record.
#
# RFC xxxx
class DNS::Zone::RR::SRV < DNS::Zone::RR::Record

  attr_accessor :priority, :weight, :port, :target

  def dump
    parts = general_prefix
    parts << priority
    parts << weight
    parts << port
    parts << target
    parts.join(' ')
  end

end
