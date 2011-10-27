require 'spec_helper'

describe "PageView" do
  json = <<-json
{
            "gd$etag":"A0UEQX47eSp7I2A9WhRTEEw",
            "gd$kind":"analytics#datarow",
            "id":{
               "$t":"http://www.google.com/analytics/feeds/data?ids=ga:51973535&ga:city=Dallas&ga:country=United%20States&ga:latitude=32.8030&ga:longitude=-96.7699&start-date=2008-10-01&end-date=2011-10-31"
            },
            "updated":{
               "$t":"2011-10-30T17:00:00.001-07:00"
            },
            "title":{
               "$t":"ga:city=Dallas | ga:country=United States | ga:latitude=32.8030 | ga:longitude=-96.7699"
            },
            "link":[
               {
                  "rel":"alternate",
                  "type":"text/html",
                  "href":"http://www.google.com/analytics"
               }
            ],
            "dxp$dimension":[
               {
                  "name":"ga:city",
                  "value":"Dallas"
               },
               {
                  "name":"ga:country",
                  "value":"United States"
               },
               {
                  "name":"ga:latitude",
                  "value":"32.8030"
               },
               {
                  "name":"ga:longitude",
                  "value":"-96.7699"
               }
            ],
            "dxp$metric":[
               {
                  "confidenceInterval":0.0,
                  "name":"ga:pageviews",
                  "type":"integer",
                  "value":"36"
               }
            ]
         }
  json
  it "should parse from json" do
    page_view = PageView.from_json(ActiveSupport::JSON.decode(json))
    page_view.longitude.should == "-96.7699"
    page_view.latitude.should == "32.8030"
    page_view.no_of_views.should == "36"
  end
end