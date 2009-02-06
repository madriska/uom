class Numeric
  # 1.lb, 1.ton, etc.
  def method_missing(meth_id, *args, &block)
    if unit = Uom::Unit[meth_id.to_sym]
      Uom::Quantity.new(self, unit)
    else
      super
    end
  end
end

class Uom::Quantity
  # 1.kg.in_lb => 2.20462262
  def method_missing(meth_id, *args, &block)
    if (meth_id.to_s =~ /^in_(.*)$/) && (code = $1) && 
        unit = Uom::Unit[code.to_sym]
      convert_to(unit).amount
    else
      super
    end
  end
end

