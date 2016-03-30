class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :user, index: true
      t.boolean :won
      t.integer :word_length
      t.integer :number_guesses_allowed
      t.integer :number_guesses
      t.integer :number_initial_words
      t.integer :number_words_left
      t.string :final_state

      t.timestamps
    end
  end
end
