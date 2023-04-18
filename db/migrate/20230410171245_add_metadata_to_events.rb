class AddMetadataToEvents < ActiveRecord::Migration[7.0]
  def up
    add_column "#{Land.config.schema}.events", :metacontent, :jsonb
  end

  def down
    remove_column "#{Land.config.schema}.events", :metacontent
  end
end
