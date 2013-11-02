Feature: Merge Articles
  As an administrator
  In order to show viewers similar articles
  I want to merge two similar articles

Background:
  Given the blog is set up

  Given the following users exist:
    |login       |email            |password  |profile     |
    |writer1     |writer1@typo.com |writer123 |publisher   |
    |writer2     |writer2@typo.com |writer123 |publisher   |
    |commenter   |comment@typo.com |comment12 |contributor |
    |admin1      |admin1@typo.com  |admin123  |admin       |

  Given the following articles exist:
    |title    |user    |body            |state     |
    |article1 |writer1 |article1_body   |published |
    |article2 |writer2 |article2_body   |published |

  Given the following comments exist:
    |author    |body |article |
    |commenter |nice |article1|
    |commenter |good |article2|

Scenario: Non-admin cannot merge articles
  Given I am logged in with "writer1" and password "writer123"
  Then I follow "All Articles"
  Then I follow "article1"
  Then I should not see "Merge Articles"

Scenario: Merged articles should contain text of both previous articles.
  Given I am logged in with "admin1" and password "admin123"
  Then I follow "All Articles"
  Then I follow "article1"
  Then I should see "Merge Articles"
  Then I fill in "merge_with" with "4"
  Then I press "Merge With This Article"
  And I go to edit path for "article1"
  Then I should see "article1_body"
  Then I should see "article2_body"

Scenario: Merged articles should have one author from the original
  Given I am logged in with "admin1" and password "admin123"
  Then I follow "All Articles"
  Then I follow "article1"
  Then I should see "Merge Articles"
  Then I fill in "merge_with" with "4"
  Then I press "Merge With This Article"
  And I go to admin page
  Then I follow "All Articles"
  Then I should see "article1"
  Then I should see "Author"

Scenario: Comments should be merged
  Given I am logged in with "admin1" and password "admin123"
  Then I follow "All Articles"
  Then I follow "article1"
  Then I should see "Merge Articles"
  Then I fill in "merge_with" with "4"
  Then I press "Merge With This Article"
  And I go to page for "article1"
  Then I should see "nice"
  Then I should see "good"

Scenario: Title should be eiter one of the previous article
  Given I am logged in with "admin1" and password "admin123"
  Then I follow "All Articles"
  Then I follow "article1"
  Then I should see "Merge Articles"
  Then I fill in "merge_with" with "4"
  Then I press "Merge With This Article"
  And I go to edit path for "article1"
  Then I should see "article1"
