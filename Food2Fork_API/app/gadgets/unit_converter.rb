require_relative '../../config/environment'

##Ingredients
#["4 small chicken breasts, pounded thin","salt and pepper to taste", "4 jalapenos, diced", "4 ounces cream cheese, room temperature", "1 cup cheddar cheese, shredded", "8 slices bacon"]

# convert all unit format to standarized few
def unit_converter (unit)

  # key value pair of key as standarized name, value as alternatives to be converted
  converter_hash = {
    "tbsp" => ["table spoon", "table spoons", "tablespoon", "tablespoons" ],
    "cup" => ["cups"],
    "pint" => ["pints", "pt", "pts"],
    "quart" => ["quarts", "qt", "qts"],
    "pieces" => ["piece"],
    "tsp" => ["tea spoon", "tea spoons", "teaspoon", "teaspoons" ],
    "fl oz" => ["fluid ounce", "fluid ounces", "fl. oz.", "oz. fl.", "fluid oz.", "fluid oz", "oz fl" ],
    "pkt" => ["pacakge", "packages", "pkg", "pkgs", "pat" ],
    "cu in" => ["cubic in", "cubic inches", "cu. in."],
    "envelp" => ["envelop", "envelope", "envelopes", "envelops"],
    "gal" => ["galn", "galns", "gals", "gallons", "gallon"],
    "slices" => ["slice"],
    "ml" => ["mls", "millilitres","millilitre","milliliter","milliliters"],
    "oz" => ["ounce", "ounces", "ozs"],
    "g" => ["gram", "grams", "gs"],
    "lb" => ["lbs", "pound", "pounds"],
    "kg" => ["kgs", "kilogram", "kilograms", "kilo", "kilos"]
  }

  # if already standarized, no change
  if converter_hash.keys.include?(unit)
    new_unit = unit
  # if in alternatives, change to standarized unit
  elsif converter_hash.values.flatten.include?(unit)
    new_unit = converter_hash.select{|key, alternatives| alternatives.include?(unit)}.keys[0]
  # if netiher, use 'item'
  else
    new_unit = "item"
  end
  return new_unit
end


# identify if an intake unit is a weight unit or volume unit
def v_or_w_identifier(unit)
  v_or_w_hash = {
    "v" => ["tbsp", "cup", "pint", "quart", "pieces", "tsp", "fl oz", "pkt", "cu in", "envelp", "gal", "slices", "ml"],
    "w" => ["oz", "g", "lb", "kg"]
  }
  if v_or_w_hash["v"].include?(unit)
    unit_v_or_w = "v"
  elsif v_or_w_hash["w"].include?(unit)
    unit_v_or_w = "w"
  else
    unit_v_or_w = "monster"
  end
  return unit_v_or_w
end

# convert volume to standard cup (can be adapted to all other units if needed)
def volume_converter(volume, unit)
  volume_converter = {
    "cup" => 1.0,
    "tbsp" => 1.0/16,
    "pint" => 2.0,
    "quart" => 4.0,
    "tsp" => 1.0/48,
    "fl oz" => 1.0/1.8327,
    "cu in" => 1/14.438,
    "gal" => 16.0,
    "ml" => 1/236.6
  }

  if !volume_converter[unit]
    volume_in_cup = nil
  else
    volume_in_cup = volume * volume_converter[unit]
  end
#  volume_hash = {}
#  volume_converter.each do |unit, conversion|
#    volume_hash[unit] = volume_in_cup * conversion
#  end
  return volume_in_cup
end

# convert volume to standard g (can be adapted to all other units if needed)
def weight_converter(weight, unit)

  weight_converter = {
    "g" => 1.0,
    "oz" => 28.35,
    "lb" => 453.6,
    "kg" => 1000.0
  }
  weight_in_g = weight * weight_converter[unit]
#  weight_hash = {}
#  weight_converter.each do |unit, conversion|
#    weight_hash[unit] = volume_in_cup * conversion
#  end
  return weight_in_g
end
