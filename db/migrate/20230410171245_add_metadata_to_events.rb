class AddMetadataToEvents < ActiveRecord::Migration[7.0]
  def up
    add_column "#{Land.config.schema}:events", :metadata, :jsonb
  end

  def down
    remove_column "#{Land.config.schema}:events", :metadata
  end
end
