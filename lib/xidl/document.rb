require 'nokogiri'

module XIDL
  # SAX document for parsing the XIDL. The SAX document is an event
  # driven XML parser provided by Nokogiri. This document is specifically
  # responsible for parsing the XIDL file into a {IDL} object.
  class Document < Nokogiri::XML::SAX::Document
    attr_reader :idl
    attr_reader :unhandled

    def start_document
      # Reset the scope for new parsing
      @scope = []
      @unhandled = []
    end

    def end_document
      # TODO: Put this in a logger or something
      # p @unhandled
    end

    def start_element(name, attrs=[])
      # Add the element to the current scope so we can know
      # at what depth we are throughout parsing
      @scope.push(name.to_sym)

      dispatch_method("start_element", Hash[*attrs.flatten])
    end

    def end_element(name)
      dispatch_method("end_element")

      # Pop the element off the scope and reset characters
      @scope.pop
    end

    def characters(string)
      dispatch_method("characters", string)
    end

    protected

    # Calls the given method if it is implemented and otherwise
    # adds it to the unhandled list.
    def dispatch_method(meth, *args)
      meth = [meth, @scope].flatten.join("_").to_sym
      return send(meth, *args) if respond_to?(meth)
      @unhandled.push(meth) if !@unhandled.include?(meth)
    end

    #------------------------------------------------------------
    # Methods below are callbacks for the various element types.
    # They are automatically called by {#start_element} and
    # {#end_element}
    #------------------------------------------------------------

    def start_element_idl(_attrs)
      @idl = IDL.new
    end

    # <idl><desc>
    def start_element_idl_desc(_attrs)
      @idl.description = ""
    end

    def characters_idl_desc(string)
      @idl.description += string
    end

    def end_element_idl_desc
      @idl.description.strip!
    end
    # </desc></idl>

    # <idl><library>
    def start_element_idl_library(attrs)
      @idl.library = @library = Library.new(attrs["name"], attrs["version"], attrs["desc"])
    end

    def end_element_idl_library
      @library = nil
    end
    # </library></idl>

    # <idl><library><result>
    def start_element_idl_library_result(attrs)
      result = Result.new
      result.name = attrs["name"]
      result.value = attrs["value"]
      result.description = ""
      @library.results << result
      @result = result
    end

    def characters_idl_library_result_desc(string)
      @result.description += string
    end

    def end_element_idl_library_result_desc
      @result.description.strip!
      @result = nil
    end
    # </result></library></idl>

    # <idl><library><enum>
    def start_element_idl_library_enum(attrs)
      @enum = Enum.new
      @enum.name = attrs["name"]

      @library.enums << @enum
    end

    def end_element_idl_library_enum
      @enum = nil
    end

    def start_element_idl_library_enum_desc(_attrs)
      @enum.description = ""
    end

    def characters_idl_library_enum_desc(string)
      @enum.description += string
    end

    def end_idl_library_enum_desc
      @enum.description.strip!
    end

    def start_element_idl_library_enum_const(attrs)
      # Ignore suppressed fields
      return if attrs["wsmap"] == "suppress"

      @const = Enum::Field.new
      @const.name = attrs["name"]
      @const.value = attrs["value"]
      @enum.fields << @const
    end

    def end_element_idl_library_enum_const
      @const = nil
    end

    def start_element_idl_library_enum_const_desc(_attrs)
      @const.description = "" if @const
    end

    def characters_idl_library_enum_const_desc(string)
      @const.description += string if @const
    end

    def end_element_idl_library_enum_const_desc
      @const.description.strip! if @const
    end
    # </enum></library></idl>

    # <idl><library><interface>
    def start_element_idl_library_interface(attrs)
      @interface = Interface.new
      @interface.name = attrs["name"]
      @interface.extends = attrs["extends"]
      @interface.uuid = attrs["uuid"] if attrs.has_key?("uuid")
      @library.interfaces << @interface
    end

    def end_element_idl_library_interface
      @interface = nil
    end

    def start_element_idl_library_interface_desc(_attrs)
      @interface.description = ""
    end

    def characters_idl_library_interface_desc(string)
      @interface.description += string
    end

    def end_element_idl_library_interface_desc
      @interface.description.strip!
    end

    def start_element_idl_library_interface_attribute(attrs)
      @attribute = Interface::Attribute.new
      @attribute.name = attrs["name"]
      @attribute.type = attrs["type"]
      @attribute.mod = attrs["mod"] if attrs.has_key?("mod")
      @attribute.readonly = attrs["readonly"] == "yes"
      @attribute.safearray = attrs["safearray"] == "yes"

      @interface.attributes << @attribute
    end

    def end_element_idl_library_interface_attribute
      @attribute = nil
    end

    def start_element_idl_library_interface_attribute_desc(_attrs)
      @attribute.description = ""
    end

    def characters_idl_library_interface_attribute_desc(string)
      @attribute.description += string
    end

    def end_element_idl_library_interface_attribute_desc
      @attribute.description.strip!
    end

    def start_element_idl_library_interface_method(attrs)
      @method = Interface::Method.new
      @method.name = attrs["name"]
      @interface.methods << @method
    end

    def end_element_idl_library_interface_method
      @method = nil
    end

    def start_element_idl_library_interface_method_desc(_attrs)
      @method.description = ""
    end

    def characters_idl_library_interface_method_desc(string)
      @method.description += string
    end

    def end_element_idl_library_interface_method_desc
      @method.description.strip!
    end

    def start_element_idl_library_interface_method_param(attrs)
      @param = Interface::Method::Param.new
      @param.name = attrs["name"]
      @param.type = attrs["type"]
      @param.dir = attrs["dir"]
      @method.params << @param
    end

    def end_element_idl_library_interface_method_param
      @param = nil
    end

    def start_element_idl_library_interface_method_param_desc(_attrs)
      @param.description = ""
    end

    def characters_idl_library_interface_method_param_desc(string)
      @param.description += string
    end

    def end_element_idl_library_interface_method_param_desc
      @param.description.strip!
    end
    # </interface></library></idl>
  end
end
