require_relative "../model/open_uri"
require_relative "../model/array_urls_product"
require_relative "../model/info"

class Main
  start_url = "https://www.petsonic.com/snacks-huesos-para-perros/"
  # start_html = Open_uri.open_url(start_url)
  all_url = Array_urls_product.get_array_urls(start_url)

  c = Info.new()

  all_url.each do |product_url|

    i = Open_uri.open_url(product_url)
    c.addInfo(i)
  end
end