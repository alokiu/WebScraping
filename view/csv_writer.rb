require "csv"

class Csv
  attr :name_file
  def initialize(name_file)
    @name_file = name_file
    CSV.open(@name_file, "wb") do |csv|
      csv << ["Product name", "price", "img"]
    end
  end
  def csv_writer(name, price, img)
    CSV.open(@name_file, "a+") do |csv|
      csv << [name, price,img]
    end
  end
end