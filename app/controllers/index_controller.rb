class IndexController < ApplicationController
  require 'net/http'
  before_action :set_key
  def welcome
    uri = URI("https://data.gov.ru/api/json/organization?access_token=#{@key}")
    response = Net::HTTP.get(uri)
    @organizations = JSON.parse(response)
  end
  def get_data
    @id = params[:id_org]
    link = URI("https://data.gov.ru/api/json/organization/#{@id}/dataset?access_token=#{@key}")
    response = Net::HTTP.get(link)
    @data_set_list = JSON.parse(response)
    @organization = Organization.new
    @organization = Organization.create ident: @id, title: params[:title]
    generate_file(@data_set_list, @id) if !(@data_set_list == [])
    redirect_to show_data_path(@id)
  end
  def show_data
    @id = params[:id_org]
    link = URI("https://data.gov.ru/api/json/organization/#{@id}/dataset?access_token=#{@key}")
    response = Net::HTTP.get(link)
    @data_set_list = JSON.parse(response)
    @organization = Organization.find_by ident: @id
    if @data_set_list == []
      render '_error.html.erb'
    end
  end
  def generate_file(json, id)
    json = json.to_json
    fJson = File.open("files/#{id}.json","w")
    fJson.write(json)
    fJson.close 
    system "zip -j files/#{id}.zip files/#{id}.json"
  end
  def download_zip
    name = params[:file]
    send_file("files/#{name}.zip")
  end
end
