require 'rails_helper'

RSpec.describe "carts/show", type: :view do
  before(:each) do
    @cart = assign(:cart, Cart.create!())
  end

  it "renders attributes in <p>" do
    render
  end
  
  it "shows the proper x in views" do
    assert_select 'h2', 'Your Pragmatic Cart'
    assert_select 'li', '1 \u00D7 Programming Ruby 1.9'
  end
end
