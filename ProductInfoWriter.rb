require 'nokogiri'
require_relative 'CsvWriter'


class ProductInfoWriter
  attr  :csv

  def initialize(fileName)
    @csv = Csv.new(fileName)
  end

  def addInfo(productUrl)
    doc = Nokogiri::HTML(productUrl)
    productArrayPrice = doc.xpath('//ul[@class="attribute_labels_lists"]/li/span[@class="attribute_price"]/text()')
    productName = doc.xpath('//h1[@class="nombre_producto"]/text()').text.strip
    productImageLink = doc.xpath('//span[@id="view_full_size"]/img[@id="bigpic"]/@src').text.strip
    if productArrayPrice == ""
      @csv.write(productName,
                 doc.xpath('//span[@id="our_price_display"]/text()').text.split(' ').first,
                 productImageLink
      )
    else
      productArrayName =  doc.xpath('//ul[@class="attribute_labels_lists"]/li/span[@class="attribute_name"]/text()')
      i = 0
      while i < productArrayName.length
        @csv.write(productName + ' - ' + productArrayName[i],
                   productArrayPrice[i].text.split(' ').first,
                   productImageLink
        )
        i+=1
      end
    end
  end
end