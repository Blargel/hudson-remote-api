module Hudson
  class Build < HudsonObject
    attr_reader :number, :job, :revisions, :result

    def initialize(job, build_number=nil)
      @job = Job.new(job) if job.kind_of?(String)
      @job = job if job.kind_of?(Hudson::Job)
      if build_number
        @number = build_number
      else
        @number = @job.last_build
      end
      @revisions = {}
      @json_api_build_info_path = File.join(Hudson[:url], "job/#{@job.name}/#{@number}/api/json")
      load_build_info
    end

    private
    def load_build_info

      build_info_json = fetch(@json_api_build_info_path)
      build_info_doc = JSON.parse(build_info_json)

      @result = build_info_doc["result"]
      if !build_info_doc["changeSet"].nil?
          build_info_doc["changeSet"]["items"].each {|item| @revisions[item["module"]] = e["revision"] }
      end
    end
  end
end
