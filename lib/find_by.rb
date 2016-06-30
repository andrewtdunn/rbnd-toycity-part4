class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval

    attributes.each do |attribute|
      # returns first
      self.send(:define_method, "find_by_#{attribute}") do |input|
        self.all().select{ |product| product.instance_eval(attribute) == input }[0]
      end
      # returns all
      self.send(:define_method, "find_all_by_#{attribute}") do |input|
        self.all().select{ |product| product.instance_eval(attribute) == input }
      end
    end
  end
end

Module.create_finder_methods("name", "brand")
