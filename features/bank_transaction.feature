Feature: Bank Transaction
  @javascript
  Scenario: Displaying
    Given the user has a "bank transaction"
    And the "bank transaction" has 5 "tags"
    And the user is on the "bank transaction" page
    Then the user sees the "description" of the "bank transaction"
    And the user sees the "posted at" of the "bank transaction"
    And the user sees the "total" of the "bank transaction"
    And the user should see "Tags"
    And the user should see "Suggested Tags"
    And the user should see "Recent Tags"
    And the user sees the "value" of every "tag"

  @javascript
  Scenario: Filtering
    Given the user has a "bank transaction"
    And the "bank transaction" has 1 "tags"
    And the "tag" has a "value" of "foo"
    And a tag exists
    And the "tag" has a "value" of "bar"
    And the user is on the "bank transactions" page
    When the user clicks on "bar"
    Then the user does not see the "bank transaction"

  @javascript
  Scenario: Adding a tag manually
    Given the user has a "bank transaction"
    And the user is on the "bank transaction" page
    When the user fills in "Tag" with "New Tag"
    And the user presses "Attach"
    Then the user should see "New Tag"
