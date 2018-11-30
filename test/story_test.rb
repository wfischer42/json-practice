require_relative 'test_helper'
require_relative '../lib/story'

class StoryTest < Minitest::Test

  def setup
    @stories = Story.from_json('./data/nytimes.json')
    @story = @stories[0]
  end

  def test_it_exists
    story = Story.new({})
    assert_instance_of(Story, story)
  end

  def test_it_can_initialize_from_json_file
    assert_instance_of(Array, @stories)
  end

  def test_all_returns_array_of_stories
    assert_equal(@stories, Story.all)
  end

  def test_story_can_return_section
    assert_equal("U.S.", @story.section)
  end

  def test_story_can_return_subsection
    assert_equal("Politics", @story.subsection)
  end

  def test_story_can_return_link
    link = "https://www.nytimes.com/2018/11/29/us/politics/trump-russia-felix-sater-michael-cohen.html"
    assert_equal(link, @story.link)
  end

  def test_story_can_return_title
    title = "How a Lawyer, a Felon and a Russian General Chased a Moscow Trump Tower Deal"
    assert_equal(title, @story.title)
  end

  def test_story_can_return_abstract
    abstract = "During the presidential campaign, Michael D. Cohen and Felix Sater, an associate with a criminal past, pursued a new Trump Tower project with a former spymaster’s help."
    assert_equal(abstract, @story.abstract)
  end

  def test_story_can_return_photo_url
    photo = "https://static01.nyt.com/images/2018/11/30/world/30trumpmoscow-1-print/30trumpmoscow7-articleInline.jpg"
    assert_equal(photo, @story.photo)
  end

  # There is not story without a normal sized photo in this data set
  # The code does this, but I don't
  def test_story_returns_not_available_if_no_photo_exists
    story_without_photo = Story.all[3]
    assert_equal("No Photo Available", story_without_photo.photo)
  end
end
