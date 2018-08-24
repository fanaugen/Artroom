class AddTokensToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end
