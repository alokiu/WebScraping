require 'nokogiri'
require_relative '../view/CsvWriter'

class ProductInfoWriter
  attr  :csv

  def initialize(file_name)
    @csv = Csv.new(file_name)
  end

  def add_info(product_url)
    doc = Nokogiri::HTML(product_url)

    product_price = doc.xpath('//span[@class="attribute_price"]').text.strip
    product_name = doc.xpath('//h1[@class="nombre_producto"]').text.strip
    product_image_link = doc.xpath('//img[@id="bigpic"]/@src').text.strip

    if product_price == ""
      @csv.write(product_name,
                 doc.xpath('//span[@id="our_price_display"]').text.strip.split(' ').first,
                 product_image_link
      )
    else
      doc.xpath('//ul[@class="attribute_labels_lists"]').each do |list|
        @csv.write(product_name + ' - ' + list.search('span.attribute_name').text.strip,
                   list.search('span.attribute_price').text.strip.split(' ').first,
                   product_image_link
        )
      end
    end
  end
end