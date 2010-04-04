$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Fluentxpath
  VERSION = '0.1.0'

  class XPath
    attr_accessor :expression

    def self.that_navigates(&block)
      xpath = self.new
      xpath.instance_eval(&block)
      return xpath.expression
    end

    def initialize
      @expression = ""
    end

    def to_root_node
      add "/"
    end

    def to_root_element
      add "/"
    end

    def to_any_element
      add "//"
    end

    def with_name(name)
      add name
    end

    def and_name(name)
      with_name(name)
    end

    def and_then
      return self
    end

    def to_children
      add "/"
    end

    def to_descendants
      add "//"
    end

    def with_attributes(attributes)
      predicates = []
      attributes.each_pair { |attribute, value| predicates << "@#{attribute}='#{value}'" }
      add "[#{predicates.sort.join(" and ")}]"
    end

    def and_attributes(attributes)
      with_attributes(attributes)
    end

    def and_attribute(attributes)
      with_attributes(attributes)
    end

    def with_attribute(attributes)
      with_attributes(attributes)
    end

    private
    def add(text)
      @expression += text
      return self
    end
  end
end
