require 'rails_helper'
require 'products_controller'

RSpec.describe ProductsController do

        let(:new_product_attributes) do
            {
                title:  "My Book Title", 
                description: "yyy", 
                image_url: "zzz.jpg", 
                price: 1,
                id: 1
            }
        end
        let(:product) { Product.create!(
                        title: "Product",
                        description: "Description",
                        price: 1,
                        id: 1,
                        image_url: "zzz.jpg"
                    ) }
    

    describe "GET index" do
        
        it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end

        it "renders the new template" do
            get :new
            expect(response).to render_template("new")
          end

        it "should create a product" do
            expect{
                post :create, product: new_product_attributes
            }.to change(Product, :count).by(1)
        end

        it "should show product" do
            get :show, id: product.id
            expect(response).to render_template :show
        end

        it "should get edit" do
            get :edit, id: product.id
            expect(response).to render_template :edit
        end

        it "should update product" do
            new_title = "New Title"
            new_description = "New Description" 
            put :update, id: product.id, product: {title: new_title, description: new_description, price: 2, image_url: "zzz.jpg"}
            
            updated_product = assigns(:product)
            expect(updated_product.id).to eq product.id
            expect(updated_product.title).to eq new_title
            expect(updated_product.description).to eq new_description
        end

        it "should destroy product" do
            delete :destroy, {id: product.id}
            expect(response).to redirect_to(products_path)
        end
    end
end

