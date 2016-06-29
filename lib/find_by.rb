class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval

    attributes.each do |attribute|
      self.send(:define_method, "find_by_#{attribute}") do |input|
        products = self.all().select{ |product| product.instance_eval(attribute) == input}
        return products[0]
      end
    end
  end
end

Module.create_finder_methods("name", "brand")
