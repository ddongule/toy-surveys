require 'csv'
namespace :import_ocock_csv do
  task :create_cocktails => :environment do
    CSV.foreach("public/o-cock-update-1.csv", :headers => true) do |row|
      Cocktail.create!(row.to_hash)
    end
  end
end
