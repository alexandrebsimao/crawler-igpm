require 'nokogiri'
require 'open-uri'
require 'sqlite3'

# http://zetcode.com/db/sqliteruby/connect/
# db = SQLite3::Database.new ":memory:"

url = 'https://www.debit.com.br/tabelas/tabela-completa.php?indice=igpm'

doc = Nokogiri::HTML(open(url))

years = doc.css('.mdl-card')

years.each do |year|
  indicators = year.css('.mdl_plan_indicadores').search('tr')
  indicators.each do |indicator|
    line = indicator.search('td')
    next if line.empty?
    reference = line.first.inner_html
    percent_value = line.last.inner_html

    puts "#{reference} | #{percent_value}%"
  end
end
