def fuzzy_matching(ingredient_long_name,ingredient_name,item)
  return strict_matching(ingredient_name,item) || probable_matching(ingredient_long_name,item) || maybe_matching(ingredient_long_name,item)
end

# match ingredient names that is part of the item string
def strict_matching(ingredient_name,item)
  return item.downcase.include?(ingredient_name)
end

# match ingredient names and item string that have more than 2 words similarity
def probable_matching(ingredient_long_name,item)
  return (item.downcase.split(" ") & ingredient_long_name.split(" ")).size >= 2
end

# match one word similarity and let user choose
def maybe_matching(ingredient_long_name,item)
  return (item.downcase.split(" ") & ingredient_long_name.split(" ")).size >= 1
end
