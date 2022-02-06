Feature: Bank Transaction
  @javascript
  Scenario: Displaying
    Given the user has a "bank transaction"
    And the user is on the "bank transaction" page
    And the "bank transaction" has a list of "tags"
    Then the user sees the "description" of the "bank transaction"
    And the user sees the "posted at" of the "bank transaction"
    And the user sees the "total" of the "bank transaction"
    And the user should see "Tags"
    And the user should see "Suggested Tags"
    And the user should see "Recent Tags"
    And the user sees the "value" of every "tag"

  @javascript
  Scenario: Adding a tag manually
    Given the user has a "bank transaction"
    And the user is on the "bank transaction" page
    When the user fills in "Tag" with "New Tag"
    And the user presses "Attach"
    Then the user should see "New Tag"
