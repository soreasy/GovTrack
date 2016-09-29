get '/' do
  redirect '/bills'
end

get '/bills' do
  @bills = [Bill.create(title: "Title", introduced_date: "date", status: "status", congress_id: 1, sponsor: "sponsor", link: "link", desc: "descrip")]
  erb :'/bills/bills'
end

get '/thingy' do
  uri = URI('https://www.govtrack.us/api/v2/bill?congress=114')
  res = Net::HTTP.get(uri)
  res
end

post '/congress' do
  uri = URI('https://www.govtrack.us/api/v2/bill?congress='+params[:congress_num]+'&limit=5')
  res = JSON.parse(Net::HTTP.get(uri))
  res["objects"].each do |bill|
    desc = bill["titles"].flatten
    desc.delete(nil)
    descrip = desc.sort_by {|el| -el.length}[0]
    Bill.create(status: bill["current_status_label"], introduced_date: bill["introduced_date"], sponsor: bill["sponsor"]["name"], title: bill["title_without_number"], desc: descrip, link: bill["link"], congress_id: params[:congress_num])
  end
  @bills = Bill.where(congress_id: params[:congress_num])
  erb :'/bills/bills'
end