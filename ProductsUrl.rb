require 'nokogiri'
require 'open-uri'

class ProductsUrl

  def self.getUrlsArray(startUrl)
    startHtml = open(startUrl,
                     "User-Agent" => "Mozilla/5.0",
                     "From" => "foo@bar.invalid",
                     "Referer" => "http://www.petsonic.com/")
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

  def self.getPageLinks(linksArray, doc)
    linksArray.concat doc.xpath("//div[@class='product-image-container image ImageWrapper']/a[@class='product_img_link']/@href")
  end
end