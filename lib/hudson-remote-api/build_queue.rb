module Hudson
  # This class provides an interface to Hudson's build queue
  class BuildQueue < HudsonObject
    def self.load_json_api
      @@json_api_build_queue_info_path = File.join(Hudson[:url], "queue/api/json")
    end

    load_json_api

    # List the jobs in the queue
    def self.list
      json = fetch(@@json_api_build_queue_info_path)
      queue = []
      queue_doc = JSON.parse(json)
      return queue if queue_doc["items"].empty?
      queue_doc["items"].each do |item|
          queue << item["task"]["name"]
      end
      queue
    end
  end
end
