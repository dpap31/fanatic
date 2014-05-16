class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :espn_uid
      t.string :name
      t.string :abbreviation
      t.string :location

      t.timestamps
    end
  end
end
