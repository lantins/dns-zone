# Parent class of all RR types, common resource record code lives here.
# Is responsible for building a Ruby object given a RR string.
#
# @abstract Each RR TYPE should subclass and override: {#load} and #{dump} 
class DNS::Zone::RR::Record

  attr_accessor :label, :ttl
  attr_reader :klass

  def initialize
    @label = '@'
    @klass = 'IN'
  end

  # FIXME: should we just: `def type; 'SOA'; end` rather then do the class name convension?
  #
  # Figures out TYPE of RR using class name.
  # This means the class name _must_ match the RR ASCII TYPE.
  #
  # When called directly on the parent class (that you should never do), it will
  #   return the string as `<type>`, for use with internal tests.
  #
  # @return [String] the RR type
  def type
    name = self.class.name.split('::').last
    return '<type>' if name == 'Record'
    name
  end

  # Returns 'general' prefix (in parts) that come before the RDATA.
  # Used by all RR types, generates: `[<label>] [<ttl>] [<class>] <type>`
  #
  # @return [Array<String>] rr prefix parts
  def general_prefix
    parts = []
    parts << label
    parts << ttl if ttl
    parts << 'IN'
    parts << type
    parts
  end

  # Build RR zone file output.
  #
  # @return [String] RR zone file output
  def dump
    general_prefix.join(' ')
  end

  # @abstract Override to update instance with RR type spesific data.
  # @param string [String] RR ASCII string data
  # @param options [Hash] additional data required to correctly parse a 'whole' zone
  # @option options [String] :last_label The last label used by the previous RR
  # @return [Object]
  def load(string, options = {})
    raise 'must be implemented by subclass'
  end

  # Load 'general' RR data/params and return the remaining RDATA for further parsing.
  #
  # @param string [String] RR ASCII string data
  # @param options [Hash] additional data required to correctly parse a 'whole' zone
  # @return [String] remaining RDATA
  def load_general_and_get_rdata(string, options = {})
    # strip comments, unless its escaped.
    string.gsub!(/(?<!\\);.*/o, "");

    captures = string.match(DNS::Zone::RR::REGEX_RR)
    return nil unless captures

    if [' ', nil].include?(captures[:label])
      @label = options[:last_label]
    else
      @label = captures[:label]
    end

    @ttl = captures[:ttl]
    captures[:rdata]
  end

end
