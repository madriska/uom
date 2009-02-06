require 'activerecord'

class <<ActiveRecord::Base
  def uom(*args)
    options = args.extract_options!.symbolize_keys
    attribute_names = args
    
    attribute_names.each do |attr_name|
      scalar_attribute = options.delete(:scalar_attribute) || 
                           :"#{attr_name}_amount"
      units_attribute  = options.delete(:units_attribute)  || 
                           :"#{attr_name}_units"
      composed_of attr_name, {:class_name => "Uom::Quantity", 
                              :mapping => [[scalar_attribute, :amount], 
                                [units_attribute, :units]]}.
                              merge(options)
    end
  end
end
