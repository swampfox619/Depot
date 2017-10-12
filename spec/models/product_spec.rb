require 'rails_helper'
require 'product'

RSpec.describe Product do
 
    describe 'attributes' do
    
        let(:product) { Product.new(title:  "My Book Title", description: "yyy", image_url: "zzz.jpg", price: 1) }
  
        it "has attributes title, description, image_url, price" do
            expect(product).to respond_to(:title)
            expect(product).to respond_to(:description)
            expect(product).to respond_to(:image_url)
            expect(product).to respond_to(:price)
        end
  
        it "attributes must not be empty" do
            expect(product.title).not_to be_empty
            expect(product.description).not_to be_empty
            expect(product.price).not_to be_nil
            expect(product.image_url).not_to be_empty
            
        end
  
        it "only allows price to be positive" do
            product = Product.new(title:  "My Book Title",
                                  description: "yyy",
                                  image_url: "zzz.jpg")
    
            product.price = -1
            expect(product.save).not_to be_truthy
          
            product.price = 0
            expect(product.save).not_to be_truthy
            
            product.price = 1
            expect(product.save).to be_truthy
        end
  
        def new_product(image_url)
            Product.new(title:        "My Book Title",
                    description:  "yyy",
                    price:        1,
                    image_url:    image_url)
        end
      
        it "passes good image_url entries" do
            new_product = Product.new(title:"My Book Title",
                                      description:  "yyy",
                                      price:        1)
            ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
        
            ok.each do |name|
                new_product.image_url = name
                expect(new_product.save).to be_truthy
            end
        end
    
        it "fails good image_url entries" do
            new_product= Product.new(title:"My Book Title",
                          description:  "yyy",
                          price:        1)
            bad = %w{ fred.doc fred.gif/more fred.gif.more }
            
            bad.each do |name|
                new_product.image_url = name
                expect(new_product.save).not_to be_truthy
            end
        end
    
        it "ensures each product has a unique title" do
            product1 = Product.new(title:"My Book Title",
              description:      "yyy",
              price:             1,
              image_url:        "image.jpg")
            product2 = Product.new(title:"My Book Title",
              description:      "zzz",
              price:            2,
              image_url:        "image1.jpg")  
              
            product1.save
            expect(product2.save).to be_falsey
        end
    end
end
