class AddBestAnswerToAnswers < ActiveRecord::Migration
  def up
    add_column :answers, :best_answer, :boolean
  end
  
  def down
    remove_column :answers, :best_answer, :boolean
  end
end
