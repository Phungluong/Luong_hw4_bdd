# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
   Movie.create movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  p1 = (page.body =~ /#{e1}/)
  p2 = (page.body =~ /#{e2}/)

  assert p1, "Page does not contain #{e1}"
  assert p2, "Page does not contain #{e2}"
  assert p1 < p2, "#{e1} occurs at #{p1}, #{e2} occurs at #{p2}"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |r|
    step uncheck.nil? ? "I check \"ratings_#{r}\"" : "I uncheck \"ratings_#{r}\""
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  page.all('table#movies tbody tr').count.should == Movie.count
end
