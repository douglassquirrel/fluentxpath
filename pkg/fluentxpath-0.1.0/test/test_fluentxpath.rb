require File.dirname(__FILE__) + '/test_helper.rb'

class TestFluentxpath < Test::Unit::TestCase
  def setup
    @xpath = Fluentxpath::XPath
  end
   
  def test_single_expressions
    assert_equal "/", @xpath.that_navigates { to_root_node }

    assert_equal "/library", @xpath.that_navigates { to_root_element.with_name "library" }
    assert_equal "/html",    @xpath.that_navigates { to_root_element.with_name "html"    }

    assert_equal "//book",   @xpath.that_navigates { to_any_element.with_name "book"    }
  end

  def test_navigation
    assert_equal "/library/subject",            @xpath.that_navigates { to_root_element.with_name "library"
                                                                        and_then.to_children.with_name "subject" }
    assert_equal "/library/subject/shelf",      @xpath.that_navigates { to_root_element.with_name "library"
                                                                        and_then.to_children.with_name "subject" 
                                                                        and_then.to_children.with_name "shelf" }
    assert_equal "/library/subject/shelf/book", @xpath.that_navigates { to_root_element.with_name "library"
                                                                        and_then.to_children.with_name "subject" 
                                                                        and_then.to_children.with_name "shelf"  
                                                                        and_then.to_children.with_name "book" }
    assert_equal "/library//book",              @xpath.that_navigates { to_root_element.with_name "library"
                                                                        and_then.to_descendants.with_name "book" }
    assert_equal "/library//shelf/book",        @xpath.that_navigates { to_root_element.with_name "library"
                                                                        and_then.to_descendants.with_name "shelf"
                                                                        and_then.to_children.with_name "book" }
  end

  def test_attributes
    assert_equal "//book[@title='The Conquest of Bread']", 
                 @xpath.that_navigates { to_any_element.with_name("book")
                                                        and_attribute("title" => "The Conquest of Bread") }
    assert_equal "//book[@author='Kropotkin' and @title='The Conquest of Bread']", 
                 @xpath.that_navigates { to_any_element.with_name("book")
                                                         and_attributes("title" => "The Conquest of Bread", "author" => "Kropotkin") }
  end

  def test_real_world_examples
   assert_equal "//div[@id='homeMedals']//tr", @xpath.that_navigates { to_any_element.with_name("div").and_attribute("id" => "homeMedals")
                                                                       and_then.to_descendants.with_name("tr") }
   assert_equal "//ul[@id='nav']/li/ul/li/a",  @xpath.that_navigates { to_any_element.with_name("ul").and_attribute("id" => "nav")
                                                                       and_then.to_children.with_name("li")
                                                                       and_then.to_children.with_name("ul")
                                                                       and_then.to_children.with_name("li")
                                                                       and_then.to_children.with_name("a") }
  end
end
