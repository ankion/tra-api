require 'zip/zipfilesystem'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'tempfile'

def download_and_sync(train)
  print "#{train.train_date}:syncing"
  train.status = :syncing
  train.save
  file = Tempfile.new('opendata')
  get_uri = URI("http://163.29.3.98/xml/#{train.train_date}.zip")
  Net::HTTP.start(get_uri.host, get_uri.port) do |get_http|
    print "#"
    get_request = Net::HTTP::Get.new get_uri
    get_http.request get_request do |get_response|
      print "#"
      File.open(file.path, 'wb') do |f|
        f.write get_response.body
        Zip::ZipFile.open(file.path) do |zipfile|
          print "#"
          zipfile.each do |xmlfile|
            print "#"
            train_info = nil
            reader = Nokogiri::XML::Reader(xmlfile.get_input_stream.read)
            ActiveRecord::Base.transaction do
              reader.each do |node|
                next if node.node_type == Nokogiri::XML::Reader::TYPE_END_ELEMENT
                if node.name == 'TrainInfo'
                  if node.attribute('CarClass').to_i > 1107
                    train_info = nil
                    next
                  end
                  print "*"
                  train_info = TrainInfo.create(
                    :tai_train_list_id => train.id,
                    :train => node.attribute('Train'),
                    :car_class => node.attribute('CarClass'),
                    :route => node.attribute('Route'),
                    :line => node.attribute('Line'),
                    :line_dir => node.attribute('LineDir'),
                    :over_night_stn => node.attribute('OverNightStn'),
                    :cripple => node.attribute('Cripple'),
                    :package => node.attribute('Package'),
                    :dinning => node.attribute('Dinning'),
                    :train_type => node.attribute('Type'),
                    :note => node.attribute('Note')
                  )
                end
                if node.name == 'TimeInfo'
                  next unless train_info
                  print "."
                  TimeInfo.create(
                    :train_info_id => train_info.id,
                    :station => node.attribute('Station'),
                    :dep_time => node.attribute('DEPTime'),
                    :arr_time => node.attribute('ARRTime'),
                    :order => node.attribute('Order'),
                    :route => node.attribute('Route')
                  )
                end
              end
            end
          end
        end
      end
    end
  end
  train.status = :success
  train.save
end

namespace :opendata do
  desc "Run all sync task"
  task :sync => :environment do
    tasks = TaiTrainList.where(:status => nil)
    tasks.each do |task|
      download_and_sync(task)
      puts "Success"
    end
    puts "All success"
  end

  desc "Sync one day data."
  task :sync_one_day, [:date] => :environment do |t, args|
    date = args[:date] || Time.now.strftime("%Y%m%d")
    tai_train_list = TaiTrainList.where(:train_date => date).first
    if tai_train_list
      if tai_train_list.status == nil
        download_and_sync(tai_train_list)
      end
    end
    puts "Success"
  end

  desc "Add sync task."
  task :add_sync_task => :environment do
    html = Nokogiri::HTML(open("http://163.29.3.98/xml/"))
    html.css('a').each do |link|
      />(\d{8})\.zip/.match(link.to_s) do |s|
        TaiTrainList.find_or_create_by(:train_date => s[1])
      end
    end
  end
end
