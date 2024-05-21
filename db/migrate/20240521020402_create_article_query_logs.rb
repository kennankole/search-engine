class CreateArticleQueryLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :article_query_logs do |t|
      t.string :query
      t.string :ip

      t.timestamps
    end
  end
end
