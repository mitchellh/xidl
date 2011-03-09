module XIDL
  class Interface
    attr_accessor :name
    attr_accessor :extends
    attr_accessor :description
    attr_accessor :uuid
    attr_reader :attributes
    attr_reader :methods

    def initialize
      @attributes = []
      @methods = []
    end

    class Attribute
      attr_accessor :name
      attr_accessor :type
      attr_accessor :mod # appears to be a type that can be used in place of the real type
      attr_accessor :readonly
      attr_accessor :safearray
      attr_accessor :description
    end

    class Method
      attr_accessor :name
      attr_accessor :description
      attr_reader :params

      def initialize
        @params = []
      end

      class Param
        attr_accessor :name
        attr_accessor :type
        attr_accessor :dir
        attr_accessor :description
      end
    end
  end
end
