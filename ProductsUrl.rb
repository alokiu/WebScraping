require 'nokogiri'
require 'mechanize'

class ProductsUrl

  def self.get_urls_array(start_url)

    agent = Mechanize.new
    html = agent.get(start_url)
    doc = Nokogiri::HTML(html.body)

    links_array = []

    get_page_links(links_array, doc)

    while doc.xpath('//ul[@class = "pagination pull-left"]/li[@id = "pagination_next_bottom"]/a/@href').
        text.strip != ""

      html = html.link_with(:xpath =>'//ul[@class = "pagination pull-left"]/li[@id = "pagination_next_bottom"]/a')
                 .click
      doc = Nokogiri::HTML(html.body)

      get_page_links(links_array, doc)
    end
    return links_array
  end

  def self.get_page_links(links_array, doc)
    links_array.concat doc.xpath('//a[@class = "product_img_link"]/@href')
  end
end