require_relative "../model/OpenUri"
require_relative "../model/ProductsUrl"
require_relative "../model/ProductInfoWriter"

class Main

  start_time = Time.now
  start_url = "https://www.petsonic.com/snacks-huesos-para-perros/"
  file_name = "file.csv"

  all_urls = ProductsUrl.get_urls_array(start_url)

  info_writer = ProductInfoWriter.new(file_name)

  all_urls.each do |productUrl|
    html = OpenUri.open_url(productUrl)
    info_writer.add_info(html)
  end
  puts (Time.now-start_time).to_s
end