require "csv"

class Csv

  attr :name_file

  def initialize(file_name)
    @name_file = file_name

    CSV.open(@name_file, "wb") do |csv|
      csv << ["Product name", "Price", "Img link"]
    end
  end

  def write(name, price, img)
    CSV.open(@name_file, "a+") do |csv|
      csv << [name, price, img]
    end
  end
end