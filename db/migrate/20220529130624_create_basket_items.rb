class CreateBasketItems < ActiveRecord::Migration[6.1]
  def change
    create_table :basket_items do |t|

      t.timestamps
    end
  end
end
