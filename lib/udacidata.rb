require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  @@deleted_row = ""

  # Your code goes here!
  def self.create(attributes = nil)
    new_product = Product.new({brand:attributes[:brand], name:attributes[:name], price:attributes[:price]})
    CSV.open(@@data_path, "a") do |csv|
        #  puts "#{new_product.id}, #{new_product.brand}, #{new_product.name}, #{new_product.price}"
        csv << [new_product.id, new_product.brand, new_product.name, new_product.price]
    end
    new_product
  end

  def self.all
    products = []
    CSV.foreach(@@data_path) do |row|
        if $. > 1
            products << Product.new({id:row[0], brand:row[1], name:row[2], price:row[3]})
        end
    end
    products
  end

  def self.first(num_products = 1)
    target_num = num_products + 1
    products = []
    CSV.foreach(@@data_path) do |row|
      if target_num == 2 and $. == 2
        return Product.new({id:row[0], brand:row[1], name:row[2], price:row[3]})
      else
        if $. > 1 and $. <= target_num
            products << Product.new({id:row[0], brand:row[1], name:row[2], price:row[3]})
        else
          if $. > 1
            return products
          end
        end
      end
    end
  end

  def self.last(num_products = 1)
    if num_products ==1
      row = CSV.read(@@data_path).last
      Product.new({id:row[0], brand:row[1], name:row[2], price:row[3]})
    else
      numLines = CSV.read(@@data_path).length
      products = []
      CSV.foreach(@@data_path) do |row|
        if $. >= (numLines - num_products) + 1
          products << Product.new({id:row[0], brand:row[1], name:row[2], price:row[3]})
        end
      end
      return products
    end
  end

  def self.find(product_id)
    CSV.foreach(@@data_path) do |row|
      if row[0].to_i == product_id.to_i
        return Product.new({id:row[0], brand:row[1], name:row[2], price:row[3]})
      end
    end
  end


  def self.destroy(product_id)
    table = CSV.table(@@data_path)
    deleted_row_num = 0
    table.each_with_index do |row, index|
      if row[0] == product_id
        deleted_row_num = index
      end
    end

    deleted_row = table.delete(deleted_row_num)

    File.open(@@data_path, 'w') do |f|
      f.write(table.to_csv)
    end

    Product.new(
                    id:deleted_row[0],
                    brand:deleted_row[1],
                    name:deleted_row[2],
                    price:deleted_row[3]
                    )
  end
end


