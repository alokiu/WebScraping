require 'nokogiri'
require_relative 'CsvWriter'

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
      product_array_price = doc.xpath('//span[@class = "attribute_price"]/text()')
      product_array_name =  doc.xpath('//span[@class = "attribute_name"]/text()')

      i = 0
      while i < product_array_name.length
        @csv.write(product_name + ' - ' + product_array_name[i],
                   product_array_price[i].text.split(' ').first,
                   product_image_link
        )
        i+=1
      end
    end
  end
end