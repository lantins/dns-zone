require 'dns/zone/rr'
require 'dns/zone/version'

# :nodoc:
module DNS

  # Represents a 'whole' zone of many resource records (RRs).
  #
  # This is also the primary namespace for the `dns-zone` gem.
  class Zone

    attr_accessor :ttl, :origin, :records

    def initialize
      @records = []
    end

    def dump
      content = []
      @records.each do |rr|
        content << rr.dump
      end

      content.join("\n") << "\n"
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
      # get entries
      entries = self.extract_entries(string)

      instance = self.new

      entries.each do |entry|
        if entry =~ /\$(ORIGIN|TTL)\s+(.+)/
          instance.ttl    = $2 if $1 == 'TTL'
          instance.origin = $2 if $1 == 'ORIGIN'
          next
        end

        if entry =~ DNS::Zone::RR::RX_RR
          rec = DNS::Zone::RR.load(entry)
          instance.records << rec if rec
        end

      end

      # read in special statments like $TTL and $ORIGIN
      # parse each RR and create a Ruby object for it
      return instance
    end

    def self.extract_entries(string)
      entries = []
      mode = :line
      entry = ''

      parentheses_ref_count = 0

      string.lines.each do |line|
        # strip comments unless escaped
        line = line.gsub(/(?<!\\);.*/o, '').chomp

        next if line.gsub(/\s+/, '').empty?

        # append to entry line
        entry << line

        quotes = entry.count('"')
        has_quotes = quotes > 0

        parentheses = entry.count('()')
        has_parentheses = parentheses > 0

        if has_quotes
          character_strings = entry.scan(/("(?:[^"\\]+|\\.)*")/).join(' ')
          without = entry.gsub(/"((?:[^"\\]+|\\.)*)"/, '')
          parentheses_ref_count = without.count('(') - without.count(')')
        else
          parentheses_ref_count = entry.count('(') - entry.count(')')
        end

        # are parentheses balanced?
        if parentheses_ref_count == 0
          if has_quotes
            without.gsub!(/[()]/, '')
            without.gsub!(/[ ]{2,}/, '  ')
            #entries << (without + character_strings)
            entry = (without + character_strings)
          else
            entry.gsub!(/[()]/, '')
            entry.gsub!(/[ ]{2,}/, '  ')
            entry.gsub!(/[ ]+$/, '')
            #entries << entry
          end
          entries << entry
          entry = ''
        end

      end

      return entries
    end

  end
end
