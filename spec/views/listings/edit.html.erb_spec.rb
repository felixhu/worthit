require 'spec_helper'

describe "listings/edit" do
  before(:each) do
    @listing = assign(:listing, stub_model(Listing,
      :address => "MyString",
      :bedrooms => 1.5,
      :minutes => 1,
      :price => 1
    ))
  end

  it "renders the edit listing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do
      assert_select "input#listing_address[name=?]", "listing[address]"
      assert_select "input#listing_bedrooms[name=?]", "listing[bedrooms]"
      assert_select "input#listing_minutes[name=?]", "listing[minutes]"
      assert_select "input#listing_price[name=?]", "listing[price]"
    end
  end
end
