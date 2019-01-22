require_relative '../../config/environment'

##Ingredients
#4 small chicken breasts, pounded thin
#salt and pepper to taste
#4 jalapenos, diced
#4 ounces cream cheese, room temperature
#1 cup cheddar cheese, shredded
#8 slices bacon

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

def v_or_w_identifier(unit)
  v_or_w_hash = {
    "v" => ["tbsp", "cup", "pint", "quart", "pieces", "tsp", "fl oz", "pkt", "cu in", "envelp", "gal", "slices", "ml"],
    "w" => ["oz", "g", "lb", "kg"]
  }
  unit_v_or_w = "v" if v_or_w_hash["v"].include?(unit)
  unit_v_or_w = "w" if v_or_w_hash["w"].include?(unit)
  return unit_v_or_w
end


def volume_converter(volume, unit)
  volume_converter = {
    "cup" => 1, "tbsp" => 1, "pint" => 1, "quart" => 1, "tsp" => 1, "fl oz" => 1, "cu in" => 1, "gal" => 1, "ml" => 1
  }
  return volume_hash
end

def weight_converter(weight, unit)

  return weight_hash
end
