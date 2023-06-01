class RemoveAdTypeIndexOnAttributions < ActiveRecord::Migration[7.0]
  def change
    remove_index 'land.attributions', column: :ad_type_id if index_exists?('land.attribtions', :ad_type_id)
  end
end