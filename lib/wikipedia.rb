class Wikipedia
  include HTTParty

  def self.search(query)
    params = {
      action: "query",
      list: "search",
      srsearch: query,
      srnamespace: 0,
      srenablerewrites: true,
      srprop: "snippet",
      srlimit: 10,
      format: "json"
    }
    response = get("https://en.wikipedia.org/w/api.php", query: params)
    response["query"]
  end

  def self.get_page(pageid, full: false)
    params = {
      action: "query",
      pageids: pageid,
      prop: "coordinates|extracts",
      explaintext: true,
      format: "json"
    }
    params[:exintro] = true unless full
    Rails.logger.info("Wikipedia API request: #{params}")
    response = get("https://en.wikipedia.org/w/api.php", query: params)
    response["query"]["pages"][pageid.to_s]
  end
end
