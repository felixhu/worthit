require 'spec_helper'

describe "regressions/index" do
  before(:each) do
    assign(:regressions, [
      stub_model(Regression,
        :constant => 1.5,
        :bedroom_coefficient => 1.5,
        :minutes_coefficient => 1.5
      ),
      stub_model(Regression,
        :constant => 1.5,
        :bedroom_coefficient => 1.5,
        :minutes_coefficient => 1.5
      )
    ])
  end

  it "renders a list of regressions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
