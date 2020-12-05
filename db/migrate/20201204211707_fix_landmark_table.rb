class FixLandmarkTable < ActiveRecord::Migration
  def change
    remove_column :landmarks, :figure_id_year_completed, :string
    add_column :landmarks, :figure_id, :integer
    add_column :landmarks, :year_completed, :integer
  end
end
