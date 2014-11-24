# coding: utf-8

class Add_xml
  def initialize(browser)
    @b = browser
  end
  def add_page(path)
    @b.goto("#{path}/administrator/import/source/add/")
  end
  def seller_id
    @b.text_field(:name => 'data[userId]')
  end
  def source_url
    @b.text_field(:name => 'data[url]')
  end
  def markup
    @b.text_field(:name => 'data[changePricePercent]')
  end
  def sizetype(type) #now can receive 0 and 1
    @b.radio(:xpath => "//input[@type='radio'][@value='#{type}']")
  end
  def add
    @b.button(:id => 'submit')
  end
end

class Source_list
  def initialize(browser)
    @b = browser
  end
  def table_id(source_count)
    @b.td(:xpath => "//tr[#{source_count}]/td[1]")
  end
  def table_userid(source_count)
    @b.td(:xpath => "//tr[#{source_count}]/td[2]")
  end
  def table_name(source_count)
    @b.link(:xpath => "//tr[#{source_count}]/td[3]/a")
  end
  def table_lastdate(source_count)
    @b.td(:xpath => "//tr[#{source_count}]/td[4]")
  end
  def table_checkdate(source_count)
    @b.td(:xpath => "//tr[#{source_count}]/td[5]")
  end
  def table_status(source_count)
    @b.td(:xpath => "//tr[#{source_count}]/td[6]")
  end
end