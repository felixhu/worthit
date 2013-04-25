require 'spec_helper'

describe "regressions/edit" do
  before(:each) do
    @regression = assign(:regression, stub_model(Regression,
      :constant => 1.5,
      :bedroom_coefficient => 1.5,
      :minutes_coefficient => 1.5
    ))
  end

  it "renders the edit regression form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", regression_path(@regression), "post" do
      assert_select "input#regression_constant[name=?]", "regression[constant]"
      assert_select "input#regression_bedroom_coefficient[name=?]", "regression[bedroom_coefficient]"
      assert_select "input#regression_minutes_coefficient[name=?]", "regression[minutes_coefficient]"
    end
  end
end
