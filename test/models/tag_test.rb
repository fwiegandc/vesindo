require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 

  	@tag = Tag.new(name: "Lorem", slug: "lorem")

  end

  test "tag debiese ser valida" do

  	assert @tag.valid?

  end

  test "tag debiese tener nombre" do

  	@tag.name = ""
  	assert_not @tag.valid?

  end

  test "tag debiese tener slug" do

  	@tag.slug = ""
  	assert_not @tag.valid?

  end

  test "tag nombre no debiese estar duplicado" do

  	@tagdup = @tag.dup
  	@tagdup.name = @tagdup.name.upcase
  	@tag.save
  	assert_not @tagdup.valid?

  end

  test "tag slug no debiese estar duplicado" do

    @tagdup = @tag.dup
    @tagdup.slug = @tagdup.slug.upcase
    @tag.save
    assert_not @tagdup.valid?

  end
end
