require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.mainpage(url)
    page = Nokogiri::HTML(open(url))
    news =[]
    page.css("li.most-popular-page-list-item").each do |li|
      news << {:rank => li.css("span.most-popular-page-list-item__rank").text,
        :link => "http://www.bbc.com#{li.css("a").attribute("href").value}",
        :headline => li.css("span.most-popular-page-list-item__headline").text
        }
    end
    news
  end
  
  def self.scrape_detail_page(url)
    news_details =[]
    detailpage = Nokogiri::HTML(open(url))
      detailpage.css("div.story-body__inner p").each do |p|
      news_details << p.text.gsub(/"/, "'")
      end
    news_details
  end

end
