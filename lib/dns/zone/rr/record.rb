class DNS::Zone::RR::Record

  attr_accessor :label, :ttl
  attr_reader :klass

  def initialize
    @label = '@'
    @klass = 'IN'
  end

  def type
    name = self.class.name.split('::').last
    return '<type>' if name == 'Record'
    name
  end

  def generic_prefix
    parts = []
    parts << label
    parts << ttl if ttl
    parts << 'IN'
    parts << type
    parts
  end

  def to_s
    generic_prefix.join(' ')
  end

  def load(string)
    raise 'must be implemented by subclass'
  end

  def load_general_and_get_rdata(string, options)
    # strip comments, unless its escaped.
    string.gsub!(/(?<!\\);.*/o, "");

    captures = string.match(DNS::Zone::RR::RX_RR)
    return nil unless captures

    if captures[:label] == ' '
      @label = options[:last_label]
    else
      @label = captures[:label]
    end

    @ttl = captures[:ttl]
    captures[:rdata]
  end

end
