require 'spec_helper'

describe "listings/show" do
  before(:each) do
    @listing = assign(:listing, stub_model(Listing,
      :address => "Address",
      :bedrooms => 1.5,
      :minutes => 1,
      :price => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address/)
    rendered.should match(/1.5/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
