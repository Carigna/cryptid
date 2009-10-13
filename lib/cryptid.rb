module Cryptid

  def self.included(cls)
    cls.extend(ClassMethods)
  end

  module ClassMethods

    def cryptid(key)
      include InstanceMethods
      validates_presence_of key
      self.instance_variable_set(:@cryptid_id, key)
    end

    def find_by_cryptid(id)
      self.send("find_by_id", id)
    end

  end

  module InstanceMethods

    def to_param
      send(self.class.instance_variable_get(:@cryptid_id))
    end

    def set_param(id)
      send("#{self.class.instance_variable_get(:@cryptid_id)}=", id)
    end

  end

end
