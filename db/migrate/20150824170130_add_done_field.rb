class AddDoneField < ActiveRecord::Migration
  def change
    add_column :support_requests, :done, :boolean
  end
end
