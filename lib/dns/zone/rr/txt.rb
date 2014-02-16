class DNS::Zone::RR::TXT < DNS::Zone::RR::Record

  attr_accessor :text

  def to_s
    parts = generic_prefix
    parts << %Q{"#{text}"}
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata
    @text = rdata.match(/"(.*)"/)[1]
    self
  end

end
