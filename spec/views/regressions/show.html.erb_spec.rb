require 'spec_helper'

describe "regressions/show" do
  before(:each) do
    @regression = assign(:regression, stub_model(Regression,
      :constant => 1.5,
      :bedroom_coefficient => 1.5,
      :minutes_coefficient => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
  end
end
