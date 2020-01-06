require 'csv'
namespace :import_ocock_csv do
  task :create_cocktails => :environment do
    CSV.foreach("public/o-cock-update-2.csv", :headers => true) do |row|
      Cocktail.create!(row.to_hash)
    end
  end
end
# rails import_ocock_csv:create_cocktails