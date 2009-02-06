# uom

A lightweight Ruby library for representing units of physical measure and
quantities represented in those units.

## Usage

1. Vendor this code and load up `lib/` in your `$:`.
2. `require 'uom'`.
3. See below.

### Units and Quantities

This library supports simple units, such as "m" (metre), as well as compound
units, such as "lb in^-2" (pounds per square inch). Unit definitions are in
`lib/uom/unit_definitions.rb`.

Measurable quantities are represented by Uom::Quantity:
  
    >> Uom::Quantity.new(15, 'cm')
    => 15 cm

The `Uom::Quantity#convert_to(units)` method converts units:

    >> Uom::Quantity.new(15, 'cm').convert_to(:ft)
    => 0.492125985 ft

### Ruby Core Extensions

uom extends Numeric, so you can generate Uom::Quantity objects like `1.cm` or
`3.2.ft`.

You can also use `in_someunit` to convert from one unit to another. For example:

    >> 15.ft.in_cm
    => 457.199999305056

    >> 32.degF.in_K
    => 273.15

### Rails / ActiveRecord Integration

uom can be installed as a Rails plugin. It will automatically load its
ActiveRecord extensions, so you can integrate with Uom::Quantity like this:

    class Person < ActiveRecord::Base
      # default columns: height_amount:numeric and height_units:text
      uom :height
      
      # You can change them like this:
      uom :weight, :scalar_attribute => 'weight',
                   :units_attribute  => 'units_of_weight'
    end

    Person.new :height => 173.cm, :weight => 75.kg

If you're not using Rails, you can load the ActiveRecord extensions by requiring
'uom/active_record'.

## To do / Quirks

* Time durations are not supported, for want of an elegant way to represent
  them. Perhaps we should wrap ActiveSupport::Duration?

* uom currently assumes that all non-temperature units are multiplicative, i.e.,
  have no constant offset involved and can therefore be represented as a
  constant factor times a base unit. This should be genericized.

* Add arithmetic support for Uom::Quantity.

## Authors

* Brad Ediger (brad.ediger at madriska.com)
* Gregory Brown (gregory.t.brown at gmail.com)
