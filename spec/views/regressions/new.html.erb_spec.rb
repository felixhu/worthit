require 'spec_helper'

describe "regressions/new" do
  before(:each) do
    assign(:regression, stub_model(Regression,
      :constant => 1.5,
      :bedroom_coefficient => 1.5,
      :minutes_coefficient => 1.5
    ).as_new_record)
  end

  it "renders new regression form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", regressions_path, "post" do
      assert_select "input#regression_constant[name=?]", "regression[constant]"
      assert_select "input#regression_bedroom_coefficient[name=?]", "regression[bedroom_coefficient]"
      assert_select "input#regression_minutes_coefficient[name=?]", "regression[minutes_coefficient]"
    end
  end
end
