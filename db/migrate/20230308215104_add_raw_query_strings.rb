class AddRawQueryStrings < ActiveRecord::Migration[7.0]
  def change
    add_column 'land.visits', :raw_query_string, :text
  end
end
