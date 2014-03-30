module DNS
  class Zone

    # The module containes resource record types supported by this gem.
    # The #{load} method will convert RR string data into a Ruby class.
    module RR

      REGEX_TTL = /\d+[wdmhs]?/i
      REGEX_KLASS = /(?<klass>IN)?/i
      REGEX_TYPE = /(?<type>A|AAAA|CNAME|HINFO|MX|NS|SOA|SPF|SRV|TXT|PTR)\s{1}/i
      REGEX_RR = /^(?<label>\S+|\s{1})\s*(?<ttl>#{REGEX_TTL})?\s*#{REGEX_KLASS}\s*#{REGEX_TYPE}\s*(?<rdata>[\s\S]*)$/i
      REGEX_DOMAINNAME = /\S+\./i
      REGEX_STRING = /((?:[^"\\]+|\\.)*)/

      # Load RR string data and return an instance representing the RR.
      #
      # @param string [String] RR ASCII string data
      # @param options [Hash] additional data required to correctly parse a 'whole' zone
      # @option options [String] :last_label The last label used by the previous RR
      # @return [Object]
      def self.load(string, options = {})
        # strip comments, unless its escaped.
        string.gsub!(/(?<!\\);.*/o, "");

        captures = string.match(REGEX_RR)
        return nil unless captures

        case captures[:type]
        when 'A' then A.new.load(string, options)
        when 'AAAA' then AAAA.new.load(string, options)
        when 'CNAME' then CNAME.new.load(string, options)
        when 'HINFO' then HINFO.new.load(string, options)
        when 'MX' then MX.new.load(string, options)
        when 'NS' then NS.new.load(string, options)
        when 'PTR' then PTR.new.load(string, options)
        when 'SOA' then SOA.new.load(string, options)
        when 'SPF' then SPF.new.load(string, options)
        when 'SRV' then SRV.new.load(string, options)
        when 'TXT' then TXT.new.load(string, options)
        else
          raise 'Unknown RR Type'          
        end
      end

      autoload :Record, 'dns/zone/rr/record'

      autoload :A,      'dns/zone/rr/a'
      autoload :AAAA,   'dns/zone/rr/aaaa'
      autoload :CNAME,  'dns/zone/rr/cname'
      autoload :HINFO,  'dns/zone/rr/hinfo'
      autoload :MX,     'dns/zone/rr/mx'
      autoload :NS,     'dns/zone/rr/ns'
      autoload :PTR,    'dns/zone/rr/ptr'
      autoload :SOA,    'dns/zone/rr/soa'
      autoload :SPF,    'dns/zone/rr/spf'
      autoload :SRV,    'dns/zone/rr/srv'
      autoload :TXT,    'dns/zone/rr/txt'
    end

  end
end
