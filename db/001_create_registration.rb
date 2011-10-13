class CreateRegistration < ActiveRecord::Migration
  def self.up
    create_table :registrations do |t|
      t.string :first_name
      t.string :last_name
      t.string :streetAddress
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :registrations
  end
end