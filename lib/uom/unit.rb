require 'rational'
module Uom
  class Unit
    
    class BadComparison < StandardError; end
    
    def self.[](unit)
      @units[unit.to_s]
    end
    
    def self.define_units(&block)
      env = UnitEnvironment.new
      env.instance_eval(&block)
      @units ||= {}
      @units.merge! env.units
    end
    
    attr_accessor :dimension, :name, :definition
    def initialize(dimension, name, definition)
      @dimension, @name, @definition = dimension, name, definition
    end

    def inspect
      "<Unit #{inspect_definition.inspect} (#{@dimension.name})>"
    end

    def inspect_definition
      return @name.to_s if @name
      case @definition
      when Array
        op, left, right = @definition
        "(#{left.inspect_definition rescue left.inspect} #{op}" \
          " #{right.inspect_definition rescue right.inspect})"
      when Unit
        @definition.inspect_definition
      else
        ''
      end
    end

    class UnitEnvironment
      instance_methods.each{|m| undef_method(m) unless m =~ /^__/ ||
        m == 'instance_eval'}

      attr_reader :units
      def initialize
        @units = {}
        @dimensions = {}
        @dimension = nil
      end

      def unit(arg)
        name, definition = if arg.is_a?(Hash)
          k = arg.keys.first 
          [k, arg[k]]
        else
          [arg, nil]
        end
        @units[name.to_s] ||= Unit.new(@dimension, name, definition)
      end

      def dimension(name)
        @dimension = dimension = find_or_create_dimension(name)
        yield if block_given?
        @dimension = nil
        dimension
      end

      def find_or_create_dimension(name)
        if name.is_a?(Hash)
          k = name.keys.first
          @dimensions[k] = Dimension.new(k, name[k])
        else
          @dimensions[name.to_s] ||= Dimension.new(name)
        end
      end

      def method_missing(id, *args, &block)
        @units[id.to_s]
      end
    end

    class Dimension
      attr_reader :name, :definition
      def initialize(name, definition=nil)
        @name, @definition = name.to_s, definition
      end

      def **(exponent)
        Dimension.new(nil, [:**, self, exponent])
      end
    end
    
  end
end
