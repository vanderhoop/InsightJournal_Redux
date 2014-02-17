class AddIpAddressColumnToEntryTable < ActiveRecord::Migration
  def change
    add_column :entries, :ip_address, :string
  end
end
