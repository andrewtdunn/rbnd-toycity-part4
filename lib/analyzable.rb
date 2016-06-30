module Analyzable
  # Your code goes here!
  def average_price(products)
    total_price = 0
    products.each do |product|
       total_price +=  product.price.to_f
    end
    (total_price/products.length).round(2)
  end

  def print_section(hash, name)
    text = ""
    text += "\nInventory by #{name}:"
    hash.each do |key, value|
        text += "\n- #{key}: #{value}"
    end
    text
  end

  def count_by_brand(products)
    brands = Hash.new(0)
    products.each do |product|
        brands[product.brand] += 1
    end
    brands
  end

  def count_by_name(products)
    names = Hash.new(0)
    products.each do |product|
        names[product.name] += 1
    end
    names
  end

  def self.print_report(products)
    report = ""
    brands = count_by_brand(products)
    names = count_by_name(products)
    report += print_section(brands, "Brand")
    report += "\n"
    report += print_section(names, "Product")
    report += "\n"\
  end

end
