require 'dns/zone/rr'
require 'dns/zone/version'

# :nodoc:
module DNS

  # Represents a 'whole' zone of many resource records (RRs).
  #
  # This is also the primary namespace for the `dns-zone` gem.
  class Zone

    # The default $TTL (directive) of the zone.
    attr_accessor :ttl
    # The primary $ORIGIN (directive) of the zone.
    attr_accessor :origin
    # Array of all the zones RRs (including the SOA).
    attr_accessor :records

    # Create an empty instance of a DNS zone that you can drive programmatically.
    #
    # @api public
    def initialize
      @records = []
      soa = DNS::Zone::RR::SOA.new
      # set a couple of defaults on the SOA
      soa.serial = Time.now.utc.strftime("%Y%m%d01")    
      soa.refresh_ttl = '3h'
      soa.retry_ttl = '15m'
      soa.expiry_ttl = '4w'
      soa.minimum_ttl = '30m'
    end

    # Helper method to access the zones SOA RR.
    #
    # @api public
    def soa
      # return the first SOA we find in the records array.
      rr = @records.find { |rr| rr.type == "SOA" }
      return rr if rr
      # otherwise create a new SOA
      rr = DNS::Zone::RR::SOA.new
      rr.serial = Time.now.utc.strftime("%Y%m%d01")    
      rr.refresh_ttl = '3h'
      rr.retry_ttl = '15m'
      rr.expiry_ttl = '4w'
      rr.minimum_ttl = '30m'
      # store and return new SOA
      @records << rr
      return rr
    end

    # Generates output of the zone and its records.
    #
    # @api public
    def dump
      content = []

      sorted_records.each do |rr|
        content << rr.dump
      end

      content.join("\n") << "\n"
    end

    # Generates pretty output of the zone and its records.
    #
    # @api public
    def dump_pretty
      content = []

      last_type = "SOA"
      sorted_records.each do |rr|
        content << '' if last_type != rr.type
        content << rr.dump
        last_type = rr.type
      end

      content.join("\n") << "\n"
    end

    # Load the provided zone file data into a new DNS::Zone object.
    #
    # @api public
    def self.load(string)
      # get entries
      entries = self.extract_entries(string)

      instance = self.new

      options = {}
      entries.each do |entry|
        if entry =~ /\$(ORIGIN|TTL)\s+(.+)/
          instance.ttl    = $2 if $1 == 'TTL'
          instance.origin = $2 if $1 == 'ORIGIN'
          next
        end

        if entry =~ DNS::Zone::RR::REGEX_RR
          rec = DNS::Zone::RR.load(entry, options)
          next unless rec
          instance.records << rec
          options[:last_label] = rec.label
        end

      end

      # read in special statments like $TTL and $ORIGIN
      # parse each RR and create a Ruby object for it
      return instance
    end

    # Extract entries from a zone file that will be later parsed as RRs.
    #
    # @api private
    def self.extract_entries(string)
      # FROM RFC:
      #     The format of these files is a sequence of entries.  Entries are
      #     predominantly line-oriented, though parentheses can be used to continue
      #     a list of items across a line boundary, and text literals can contain
      #     CRLF within the text.  Any combination of tabs and spaces act as a
      #     delimiter between the separate items that make up an entry.  The end of
      #     any line in the master file can end with a comment.  The comment starts
      #     with a ";" (semicolon). 

      entries = []
      mode = :line
      entry = ''

      parentheses_ref_count = 0

      string.lines.each do |line|
        # strip comments unless escaped
        # strip comments, unless its escaped.
        # skip semicolons within "quote segments" (TXT records)
        line = line.gsub(/((?<!\\);)(?=(?:[^"]|"[^"]*")*$).*/o, "").chomp

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

    private

    # Records sorted with more important types being at the top.
    #
    # @api private
    def sorted_records
      # pull out RRs we want to stick near the top
      top_rrs = {}
      top = %w{SOA NS MX SPF TXT}
      top.each { |t| top_rrs[t] = @records.select { |rr| rr.type == t } }

      remaining = @records.reject { |rr| top.include?(rr.type) }

      # sort remaining RRs by type, alphabeticly
      remaining.sort! { |a,b| a.type <=> b.type }

      top_rrs.values.flatten + remaining
    end


  end
end
