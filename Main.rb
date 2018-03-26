require_relative "ProductsUrl"
require_relative "ProductInfoWriter"
require 'open-uri'
require 'ruby-progressbar'

class Main
  now =Time.now
  startUrl = ARGV[0]
  fileName = ARGV[1]
  puts 'Скрипт ищит все ссылки продуктов'
  allUrls = ProductsUrl.getUrlsArray(startUrl)

  infoWriter = ProductInfoWriter.new(fileName)
  progress = ProgressBar.create(:title => 'Загрузка информации со страниц', :total => allUrls.length)
  allUrls.each do |productUrl|
    html = open(productUrl)
    infoWriter.addInfo(html)
    progress.increment

  end
  puts "Время работы скрипта - " + (Time.now - now).to_s

end
