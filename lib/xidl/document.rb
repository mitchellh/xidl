require 'nokogiri'

module XIDL
  # SAX document for parsing the XIDL. The SAX document is an event
  # driven XML parser provided by Nokogiri. This document is specifically
  # responsible for parsing the XIDL file into a {IDL} object.
  class Document < Nokogiri::XML::SAX::Document
    def start_document
    end

    def start_element(name, attrs=[])
    end

    def end_element
    end
  end
end
