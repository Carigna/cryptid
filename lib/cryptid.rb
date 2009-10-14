module Cryptid
  PRIME = 2654435761412392
  MAXID = 2**31-1
  module ClassMethods
    def find_with_cryptid( *args )
        include InstanceMethods
        options = args.extract_options!
        validate_find_options(options)
        set_readonly_option!(options)

        case args.first
          when :first then find_initial(options)
          when :last  then find_last(options)
          when :all   then find_every(options)
          else             find_from_cryptids(args, options)
        end
    end

    def find_from_cryptids(cryptids, options)
        ids = Array.new
        cryptids.each { |id|
            decrypted_id = id.split(/00000/)
	        checksum = (decrypted_id[1].to_i * PRIME & MAXID)
	        if(checksum == decrypted_id[0].to_i)
			  ids << decrypted_id[1].to_i
			end
        }
        find_from_ids(ids, options)
    end

    def to_param
    end
  end

  def self.included(base)
    base.class_eval do
      extend ClassMethods
      class << self
        alias_method_chain :find, :cryptid
      end
    end
  end

  module InstanceMethods
    def to_param
      (id * PRIME & MAXID).to_s + "00000" + id.to_s
    end
  end

end
