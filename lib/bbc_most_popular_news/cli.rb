require 'colorize'
require_relative "scraper.rb"
require_relative "bbc_mp_news.rb"

class CommandLineInteface
  BASE_URL = "http://www.bbc.com/news/popular/read"
  
  def run
    make_news
    add_details_to_news
    display_news
  end

  def make_news
    news_array = Scraper.mainpage(BASE_URL)
    BbcMpNews.create_from_collection(news_array)
  end

  def add_details_to_news
    BbcMpNews.all.each do |news|
      details = Scraper.scrape_detail_page(news.link)
      news.add_details_attribute(details)
    end
  end

  def display_news
     input=""
     until input.downcase == "exit"
        puts "\e[H\e[2J"
        puts "BBC MOST POPULAR:READ NEWS".colorize(:blue)
        puts
        BbcMpNews.all.each do |newsitem|
        puts "#{newsitem.rank}.".rjust(3) + "  #{newsitem.headline}"
        end
        puts ""
        print "Enter the rank number for more details or type 'exit':".colorize(:light_blue)
        input = gets.strip
          if input.to_i.between?(1,10)
            display_details(input)
            puts "Press return to see the list again or type 'exit'.".colorize(:light_blue)
            input = gets.strip
          end
      end
  end

  def display_details(rank)
    newsobject = BbcMpNews.all.detect { |news| news.rank == rank}
    puts newsobject.headline.colorize(:green).underline
    puts
    newsobject.details.each do |detail|
    puts detail
    puts
    end
  end

end