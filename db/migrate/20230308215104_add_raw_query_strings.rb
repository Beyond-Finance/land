class AddRawQueryStrings < ActiveRecord::Migration[7.0]
  def change
    with_options schema: Land.config.schema do |t|
      add_column :visits, :raw_query_string, :text
    end
  end
end
