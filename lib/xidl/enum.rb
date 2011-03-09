module XIDL
  class Enum
    attr_accessor :name
    attr_accessor :uuid
    attr_accessor :description
    attr_reader :fields

    def initialize
      @fields = []
    end

    class Field
      attr_accessor :name
      attr_accessor :value
      attr_accessor :description
    end
  end
end
