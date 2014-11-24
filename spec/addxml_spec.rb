# coding: utf-8

load File.dirname(__FILE__) + '/../spec_helper.rb'

describe 'Add XML', :feature => "XML import", :severity => :normal do
include SpecHelper

 before(:all) do
  @auth = Auth.new(@browser)
  @addxml = Add_xml.new(@browser)
  @source_list = Source_list.new(@browser)
  @auth.log_in('username', 'password')
 end

  it 'should add xml', :story => "XML story", :severity => :critical do |e|
     e.step "go to add page" do
     @addxml.add_page(@base_url)
     end
     e.step "page loaded?" do
     expect(@browser.url).to eq("#{@base_url}/administrator/import/source/add/") #because I don't care about object identity
     end
	   e.step "add seller_id" do
     @addxml.seller_id.when_present.set '2771'
     end
     e.step "add source url" do
       @addxml.source_url.set "#{@base_url}/test_xml.xml"
     end
     e.step "add markup" do
       @addxml.markup.set '30'
     end
     e.step "set sizetype" do
       @addxml.sizetype('0').click
     end
     e.step "add xml" do
       @addxml.add.click
     end
     e.step "Is xml added?" do
       #a source list loaded
       expect(@browser.url).to eq("#{@base_url}/administrator/import/source/list/") #because I don't care about object identity
       #and i have my xml in source list
       expect(@source_list.table_name('last()').text).to eq("#{@base_url}/test_xml.xml")
     end
     e.step "Status is Ожидание первоначальной загрузки xml" do
       expect(@source_list.table_status('last()').text).to eq("Ожидание первоначальной загрузки xml")
     end
   end
end