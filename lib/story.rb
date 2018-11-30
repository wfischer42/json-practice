require 'json'

class Story
  attr_reader :data, :section, :subsection, :title, :abstract, :link, :photo

  def initialize(data)
    return nil if data.empty?
    @data = data
    @section = data["section"]
    @subsection = data["subsection"]
    @title = data["title"]
    @abstract = data["abstract"]
    @link = data["url"]
    @photo = parse_multimedia(data["multimedia"], "Normal")
  end

  def self.from_json(filename)
    file = File.read(filename)
    data = JSON.parse(file)
    @@stories = data["results"].map do |story_data|
      Story.new(story_data)
    end
  end

  def self.all
    @@stories
  end

  private
    def parse_multimedia(media_set, format)
      media_set.to_a.each do |media|
        if media["format"] == format
          return media["url"]
        end
      end
      return "No Photo Available"
    end
end
