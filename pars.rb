require 'open-uri'
require 'ruby-progressbar'
require 'nokogiri'
require "csv"


class Pars
  attr_reader :startUrl, :fileName

  def initialize(startUrl, fileName)
    @startUrl = startUrl
    @fileName = fileName

    CSV.open(fileName, "wb") do |csv|
      csv << ["Product name", "Price", "Img link"]
    end
  end

  def getUrlsArray()
    startHtml = open(@startUrl, "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; Win64; x86) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36")
    doc = Nokogiri::HTML(startHtml)

    linksArray = []
    getPageLinks(linksArray, doc)
    nextUrl = doc.xpath('//li[@id="pagination_next_bottom"]/a/@href')
    while nextUrl.text.strip != ""

      url = 'https://www.petsonic.com' + nextUrl.to_s
      nextHtml = open(url)
      doc = Nokogiri::HTML(nextHtml)

      getPageLinks(linksArray, doc)
      nextUrl = doc.xpath('//li[@id="pagination_next_bottom"]/a/@href')
    end
    return linksArray
  end

  def getPageLinks(linksArray, doc)
    linksArray.concat doc.xpath("//div[@class='product-image-container image ImageWrapper']/a[@class='product_img_link']/@href")
  end

  def addInfo(productUrl)
    doc = Nokogiri::HTML(productUrl)
    productArrayPrice = doc.xpath('//ul[@class="attribute_labels_lists"]/li/span[@class="attribute_price"]/text()')
    productName = doc.xpath('//h1[@class="nombre_producto"]/text()').text.strip
    productImageLink = doc.xpath('//span[@id="view_full_size"]/img[@id="bigpic"]/@src').text.strip
    if productArrayPrice == ""
      write(productName,
                 doc.xpath('//span[@id="our_price_display"]/text()').text.split(' ').first,
                 productImageLink
      )
    else
      productArrayName =  doc.xpath('//ul[@class="attribute_labels_lists"]/li/span[@class="attribute_name"]/text()')
      i = 0
      while i < productArrayName.length
        write(productName + ' - ' + productArrayName[i],
                   productArrayPrice[i].text.split(' ').first,
                   productImageLink
        )
        i+=1
      end
    end
  end

  def write(name, price, img)
    CSV.open(@fileName, "a+") do |csv|
      csv << [name, price, img]
    end
  end
end

now =Time.now

startUrl = ARGV[0]
fileName = ARGV[1]

pars = Pars.new(startUrl, fileName)

puts 'Скрипт ищит все ссылки продуктов'
allUrls = pars.getUrlsArray()


progress = ProgressBar.create(:title => 'Загрузка информации со страниц', :total => allUrls.length)
allUrls.each do |productUrl|
  html = open(productUrl, "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; Win64; x86) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36")
  pars.addInfo(html)
  progress.increment

end
puts "Время работы скрипта - " + (Time.now - now).to_s