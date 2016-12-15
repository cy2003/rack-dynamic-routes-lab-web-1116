

class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match("items")
      item = req.path.split("/").last
      price = find_price(item)
      if price != nil
        resp.write "#{price}"
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish

  end

  def find_price(item)
    @@items.find do |item_object|
      if item_object.name == item
        return item_object.price
      else
        return nil
      end
    end
  end

end
