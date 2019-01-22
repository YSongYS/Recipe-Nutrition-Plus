
# take in unit in recipe and convert to a common unit recognizable by the ingredient class
def unit_converter(unit)
  good_unit = []
  good_unit << Ingredient.pluck(:common_unit_volume)
  good_unit << "g"

  converter_hash = {
    "tbsp" => ["table spoon", "table spoons", "tablespoon", "tablespoons" ],
    "oz" => ["ounce", "ounces", "ozs"],
    "tsp" => ["tea spoon", "tea spoons", "teaspoon", "teaspoons" ],
    "fl oz" => ["fluid ounce", "fluid ounces", "fl. oz.", "oz. fl.", "fluid oz.", "fluid oz", "oz fl" ],
    "pkt" => ["pacakge", "packages", "pkg", "pkgs" ],
    "cu in" => ["cubic in", "cubic inches", "cu. in."],
    "envelp" => ["envelop", "envelope", "envelopes", "envelops"],
    "gal" => ["galn", "galns", "gals", "gallons"],
    "galn" => ["gal", "gals", "galns" "gallons"],
    "pkg" => ["pacakge", "packages", "pkt", "pkts" ]
  }

end
