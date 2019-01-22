require_relative '../config/environment'

# in case of re-seed, destroy previous record, need to be mindful of cumulating ids
Ingredient.destroy_all

def convert_volume_to_smallest_denominator (original_unit_volume)
  # take anything after space as unit
  common_unit_volume = original_unit_volume.split(' ',2)[1].downcase
  common_unit_volume = unit_converter (common_unit_volume)

  # read string into float
  divider = number_reader(original_unit_volume.split(' ',2)[0])

  return common_unit_volume, divider
end


def get_short_name (ingredient_long_name)
  ingredient_name = ingredient_long_name.split(",")[0]
  return ingredient_name
end


# read the raw data file from USFDA
csv = File.read('app/data_cleaning/nutrition.csv')
id = 0
CSV.parse(csv, headers: true).each do |row|
  id += 1
  # reading in long name and convert to short name
  ingredient_long_name = row.fields[0].downcase
  ingredient_name = get_short_name(row.fields[0]).downcase

  # reading in original volume and get volume divider
  common_unit_volume, divider = convert_volume_to_smallest_denominator(row.fields[1])

  # convert rest of nutirional value based on denominator
  equivalent_weight_g = row.fields[2].to_f/divider
  calories_kCal = row.fields[3].to_f/divider
  fat_g = row.fields[4].to_f/divider
  carbo_g = row.fields[5].to_f/divider
  protein_g = row.fields[6].to_f/divider

  #
  equivalent_volume_cup = volume_converter(1,common_unit_volume)

  # create new record hash
  new_record = {
    ingredient_long_name:ingredient_long_name,
    ingredient_name:ingredient_name,
    common_unit_volume:common_unit_volume,
    equivalent_weight_g:equivalent_weight_g,
    calories_kCal:calories_kCal,
    fat_g:fat_g,
    carbo_g:carbo_g,
    protein_g:protein_g,
    equivalent_volume_cup:equivalent_volume_cup
  }

  # store new record hash to the table
  Ingredient.create(new_record)

  # testing if the fraction works
  #binding.pry if divider == 0.5
end
