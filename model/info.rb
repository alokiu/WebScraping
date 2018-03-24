require 'nokogiri'
require_relative '../view/csv_writer'

class Info
  attr  :csv

  def initialize
    @csv = Csv.new("file.csv")
  end

  def addInfo(product_url)
    doc = Nokogiri::HTML(product_url)

    price = doc.xpath('//span[@class="attribute_price"]').text.strip
    name = doc.xpath('//h1[@class="nombre_producto"]').text.strip
    img = doc.xpath('//img[@id="bigpic"]/@src').text.strip
    if price == ""
      @csv.csv_writer(name, doc.xpath('//span[@id="our_price_display"]').text.strip.split(' ').first, img)

    else
      doc.xpath('//ul[@class="attribute_labels_lists"]').each do |list|
        @csv.csv_writer(name + ' - ' + list.search('span.attribute_name').text.strip, list.search('span.attribute_price').text.strip.split(' ').first, img)


      end
    end
  end
end