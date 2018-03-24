require 'nokogiri'
require 'mechanize'

class Array_urls_product
  def self.get_array_urls(start_html)

    agent = Mechanize.new
    html = agent.get(start_html)
    doc = Nokogiri::HTML(html.body)
    link = []
    doc.css('.product_img_link').each do |product|
      a_href = product['href']
      link.push(a_href)


    end

    while(doc.xpath('//ul[@class = "pagination pull-left"]/li[@id = "pagination_next_bottom"]/a/@href').text.strip !="")

      next_link = html.link_with(:xpath =>'//ul[@class = "pagination pull-left"]/li[@id = "pagination_next_bottom"]/a')
      html = next_link.click
      doc = Nokogiri::HTML(html.body)

      doc.css('.product_img_link').each do |product|
        a_href = product['href']
        link.push(a_href)

      end
    end
    return link
  end
end