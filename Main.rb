require_relative "ProductsUrl"
require_relative "ProductInfoWriter"
require 'open-uri'

class Main
  now =Time.now
  startUrl = ARGV[0]
  fileName = ARGV[1]
  allUrls = ProductsUrl.getUrlsArray(startUrl)


  infoWriter = ProductInfoWriter.new(fileName)

  allUrls.each do |productUrl|
    html = open(productUrl)
    infoWriter.addInfo(html)
  end
  puts (Time.now - now).to_s

end
