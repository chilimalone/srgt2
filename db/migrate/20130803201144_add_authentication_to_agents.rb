class AddAuthenticationToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :username, :string
    add_column :agents, :password_hash, :string
    add_column :agents, :password_salt, :string
  end
end