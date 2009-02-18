module Uom
  class Quantity
    include UnitMath
    
    attr_reader :amount, :unit_definition
    def initialize(amount, unit_definition)
      @amount = amount
      @unit_definition = unit_definition
    end

    def sexp
      case @unit_definition
        when Array
          op = @unit_definition.first
          args = @unit_definition[1..-1].map{|x| x.sexp rescue x.inspect}
          "(#{op} #{args.join(" ")})"
        else
          @unit_definition.sexp rescue @unit_definition.inspect
      end
    end
    
  end
end
