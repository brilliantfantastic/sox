module SpecHelper
  def load_fixture(fixture)
    fixture_path = File.join File.expand_path(File.dirname(__FILE__)), 'fixtures'
    File.readlines(File.join(fixture_path, fixture)).join "\n"
  end
end
