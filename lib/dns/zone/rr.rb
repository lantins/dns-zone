module DNS
  class Zone

    # The module containes resource record types supported by this gem.
    # The #{load} method will convert RR string data into a Ruby class.
    module RR

      RX_TTL = /(?<ttl>\d+[wdmhs]?)?/i
      RX_KLASS = /(?<klass>IN)?/i
      RX_TYPE = /(?<type>A|AAAA|CNAME|MX|NS|SRV|TXT)\s{1}/i
      RX_RR = /^(?<label>\S+|\s{1})\s*#{RX_TTL}\s*#{RX_KLASS}\s*#{RX_TYPE}\s*(?<rdata>[\s\S]*)$/i

      # Load RR string data and return an instance representing the RR.
      #
      # @param string [String] RR ASCII string data
      # @param options [Hash] additional data required to correctly parse a 'whole' zone
      # @option options [String] :last_label The last label used by the previous RR
      # @return [Object]
      def self.load(string, options = {})
        # strip comments, unless its escaped.
        string.gsub!(/(?<!\\);.*/o, "");

        captures = string.match(RX_RR)
        return nil unless captures

        case captures[:type]
        when 'A' then A.new.load(string, options)
        when 'TXT' then TXT.new.load(string, options)
        else
          raise 'Unknown RR Type'          
        end
      end

      autoload :Record, 'dns/zone/rr/record'

      autoload :A,      'dns/zone/rr/a'
      autoload :AAAA,   'dns/zone/rr/aaaa'
      autoload :CNAME,  'dns/zone/rr/cname'
      autoload :MX,     'dns/zone/rr/mx'
      autoload :NS,     'dns/zone/rr/ns'
      autoload :SRV,    'dns/zone/rr/srv'
      autoload :TXT,    'dns/zone/rr/txt'
    end

  end
end
