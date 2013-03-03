class Sample
  include Kahana::Service

  headers  'User-Agent' => "Kahana"
  format   :json
  params   :key => "ApiKey"
  endpoint "http://impact.brighterplanet.com/"


  # Block notation for defining middleware
  middleware do |m|
    #m.response  :mashify
    m.response  :em_json
    m.request   :multipart
    m.request   :url_encoded
    #m.adapter   :em_http #SERVICE_ADAPTER

  end

  get "electricity_uses",
      "automobiles"

  post "something"

  # http://impact.brighterplanet.com/electricity_uses.json?
  # date=2012-02-10&energy=18000&zip_code=18018
  def self.electricity_emissions(options = {})
    get("electricity_uses", options)
  end

  def self.automobile(annual_distance)
    get("automobiles", { :annual_distance => annual_distance,
                         :timeframe => "2012-01-01%2F2013-01-01" })
  end
end

