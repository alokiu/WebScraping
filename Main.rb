require_relative "OpenUri"
require_relative "ProductsUrl"
require_relative "ProductInfoWriter"

class Main

  start_url = ARGV[0]
  file_name = ARGV[1]

  all_urls = ProductsUrl.get_urls_array(start_url)


  info_writer = ProductInfoWriter.new(file_name)
  puts all_urls[0]
  all_urls.each do |productUrl|


    html = OpenUri.open_url(productUrl)
    info_writer.add_info(html)
  end
end