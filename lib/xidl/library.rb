module XIDL
  class Library
    attr_reader :name
    attr_reader :version
    attr_reader :description
    attr_reader :results
    attr_reader :enums

    def initialize(name, version, description)
      @name = name
      @version = version
      @description = description
      @results = []
      @enums = []
    end
  end
end
