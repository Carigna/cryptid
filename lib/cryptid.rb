module Cryptid
  CRYPTID_PRIME = 2654435761412392
  CRYPTID_MAXID = 2**31-1

  module ClassMethods
    def encrypt_id
      class << self
        alias_method_chain :find, :cryptid
      end
      include InstanceMethods unless included_modules.include?(InstanceMethods)
    end

    def find_with_cryptid( *args )
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
      cryptids.each do |id|
        decrypted_id = id.to_s.split(/9/,2)
        checksum = (decrypted_id[1].to_i * CRYPTID_PRIME & CRYPTID_MAXID)
        if(checksum == decrypted_id[0].to_i(9))
          ids << decrypted_id[1].to_i
        end
      end
      find_from_ids(ids, options)
    end
  end

  module InstanceMethods
    def to_param
      ((id * CRYPTID_PRIME & CRYPTID_MAXID).to_s(9) + "9" + id.to_s).to_i
    end
  end

end
