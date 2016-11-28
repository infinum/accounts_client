module ResponseLoader
  def response(action:, type:)
    File.read("spec/fixtures/response/#{action}/#{type}.txt")
  end
end
