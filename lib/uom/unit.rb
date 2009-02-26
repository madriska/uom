require 'rational'
module Uom
  class Unit
    include UnitMath
    include Errors
    
    attr_accessor :dimension, :name, :definition
    def initialize(dimension, name, definition)
      @dimension, @name, @definition = dimension, name, definition
    end

    def sexp
      @name.to_s
    end

    def self.unit(arg)
      @units ||= {}
      name, definition = if arg.is_a?(Hash)
        k = arg.keys.first 
        [k, arg[k]]
      else
        [arg, nil]
      end
      @units[name.to_s] ||= Unit.new(@dimension, name, definition)
      
      # Define the method concretely; using method_missing for this can
      # cause problems because s() is defined by SexpProcessor.
      meta_def(name){ @units[name.to_s] }

      @units[name.to_s]
    end

    def self.[](unit)
      @units[unit.to_s]
    end
    
    def self.dimension(name=nil)
      @dimension = dimension = name.to_sym
      yield if block_given?
      @dimension = nil
      dimension
    end

  end
end
