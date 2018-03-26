require "csv"

class Csv

  attr :nameFile

  def initialize(fileName)
    @nameFile = fileName

    CSV.open(@nameFile, "wb") do |csv|
      csv << ["Product name", "Price", "Img link"]
    end
  end

  def write(name, price, img)
    CSV.open(@nameFile, "a+") do |csv|
      csv << [name, price, img]
    end
  end
end