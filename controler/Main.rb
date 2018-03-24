require_relative "../model/OpenUri"
require_relative "../model/ProductsUrl"
require_relative "../model/ProductInfoWriter"

class Main

  start_url = ARGV[0]
  file_name = ARGV[1]

  all_urls = ProductsUrl.get_urls_array(start_url)

  info_writer = ProductInfoWriter.new(file_name)

  all_urls.each do |productUrl|
    html = OpenUri.open_url(productUrl)
    info_writer.add_info(html)
  end
end