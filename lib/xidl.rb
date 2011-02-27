module XIDL
  autoload :Document, 'xidl/document'
  autoload :Enum, 'xidl/enum'
  autoload :IDL, 'xidl/idl'
  autoload :Library, 'xidl/library'
  autoload :Result, 'xidl/result'

  # Parse the given XIDL file and return the parsed version
  # of it.
  #
  # @param [String] file
  # @return Object
  def self.parseFile(file)
    # Lazy load nokogiri here
    require 'nokogiri'

    # Parse the XIDL file using an event-driven parser
    doc = Document.new
    parser = Nokogiri::XML::SAX::Parser.new(doc)
    parser.parse(File.read(file))
    doc.idl
  end
end
