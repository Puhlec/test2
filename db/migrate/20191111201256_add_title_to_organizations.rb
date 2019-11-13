class AddTitleToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :title, :string
  end
end
