require 'dns/zone/rr'
require 'dns/zone/version'

# :nodoc:
module DNS

  # Represents a 'whole' zone of many resource records (RRs).
  #
  # This is also the primary namespace for the `dns-zone` gem.
  class Zone

    attr_accessor :ttl, :origin

    def initialize
    end

    # FROM RFC:
    #     The format of these files is a sequence of entries.  Entries are
    #     predominantly line-oriented, though parentheses can be used to continue
    #     a list of items across a line boundary, and text literals can contain
    #     CRLF within the text.  Any combination of tabs and spaces act as a
    #     delimiter between the separate items that make up an entry.  The end of
    #     any line in the master file can end with a comment.  The comment starts
    #     with a ";" (semicolon). 

    def self.load(string)
      # loop over each line, remove comments, a single RR may span multiple lines
      string.lines.each do |line|
        puts "parsing --- : #{line}"

        # strip comments, unless its escaped.
        line.gsub!(/(?<!\\);.*/o, "");
        captures = line.match(DNS::Zone::RR::RX_RR)
        p captures
        #return nil unless captures
      end

      # read in special statments like $TTL and $ORIGIN
      # parse each RR and create a Ruby object for it
      return self.new
    end

  end

end
