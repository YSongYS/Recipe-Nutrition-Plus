require_relative '../../config/environment'

def get_recipe_bank
  recipe_bank = [
    {:recipe_id=>"26851", :recipe_name=>"Roast Sticky Chicken Rotisserie Style", :ingredients=>["4 teaspoons salt", "2 teaspoons paprika",
    "1 teaspoon onion powder", "1 teaspoon dried thyme", "1 teaspoon white pepper", "1/2 teaspoon cayenne pepper", "1/2 teaspoon black pepp
    er", "1/2 teaspoon garlic powder", "2 onions, quartered", "4 pound whole chickens"]},
    {:recipe_id=>"35120", :recipe_name=>"Bacon Wrapped Jalapeno Popper Stuffed Chicken", :ingredients=>["4 small chicken breasts, pounded t
    hin", "salt and pepper to taste", "4 jalapenos, diced", "4 ounces cream cheese, room temperature", "1 cup cheddar cheese, shredded", "8
     slices bacon\n"]},
    {:recipe_id=>"36996", :recipe_name=>"Spinach Frittata", :ingredients=>["1 lb spinach leaves (about 2 bunches), cleaned, chopped", "1 Tbsp olive oil", "1 medium onion, chopped (about 1 cup)", "1 large clove garlic, minced", "9 large eggs", "2 Tbsp milk", "1/3 cup grated
    Parmesan cheese", "Sun-dried tomatoes, about 2 Tbsp chopped", "Salt and freshly ground pepper to taste", "3 oz goat cheese\n"]},
    {:recipe_id=>"54400", :recipe_name=>"Smashed Chickpea & Avocado Salad Sandwich", :ingredients=>["1 (15 ounce) can chickpeas or garbanzo
     beans (I use Bush's Garbanzo Beans)", "1 large ripe avocado", "1/4 cup fresh cilantro, chopped", "2 tablespoons chopped green onion",
    "Juice from 1 lime", "Salt and pepper, to taste", "Bread of your choice (I use whole wheat bread)", "Fresh spinach leaves or other sand
    wich toppings: lettuce, tomato slices, sprouts, etc."]},
    {:recipe_id=>"37047", :recipe_name=>"Swedish Meatballs", :ingredients=>["1 large yellow or white onion, peeled, grated (through a chees
    e grater)", "2 Tbsp butter", "2/3 cup milk", "4-5 slices of bread, crusts removed, bread cut into pieces", "2 eggs", "1 pound ground po
    rk", "1 1/2 pounds ground beef", "2 teaspoons salt", "1 teaspoon freshly ground nutmeg", "1 teaspoon ground cardamom", "2 teaspoons bla
    ck pepper", "6 Tbsp butter", "1/3 cup flour", "1 quart beef stock", "1/2 to 3/4 cup sour cream", "Salt", "2 to 4 Tbsp of Lingonberry, c
    ranberry, red currant or raspberry jelly, more or less to taste (optional)\n"]},
    {:recipe_id=>"35107", :recipe_name=>"Bacon Double Cheese Burger Dip", :ingredients=>["1/2 pound ground beef", "6 strips bacon, cut into
     1 inch pieces", "1 small onion, diced", "1 clove garlic, chopped", "4 ounces cream cheese, room temperature", "1/2 cup sour cream", "1
    /4 cup mayonnaise", "1/2 cup mozzarella, shredded", "1/2 cup cheddar cheese, shredded", "1 tablespoon worcestershire sauce", "2 tablesp
    oon ketchup\n"]}
  ]
  return recipe_bank
end

def seed_recipe
  common_foods = ["chicken","spinach","beef"]
  common_foods.each do |common_food|
    recipe1 = []
    recipe1 = get_top_recipes(common_food) #testing for 2 recipes for now
    number_wanted = 10

    i = 0
    while i< number_wanted do
      recipe_id, recipe_name, ingredients = get_selected_recipes(i, recipe1)
      temp_hash = {}
      temp_hash[:recipe_id] = recipe_id
      temp_hash[:recipe_name] = recipe_name
      temp_hash[:ingredients] = ingredients
      RECIPEBANK2 << temp_hash
      i += 1
    end
  end
end
