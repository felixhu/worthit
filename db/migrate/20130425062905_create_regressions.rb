class CreateRegressions < ActiveRecord::Migration
  def change
    create_table :regressions do |t|
      t.float :constant
      t.float :bedroom_coefficient
      t.float :minutes_coefficient

      t.timestamps
    end
  end
end
