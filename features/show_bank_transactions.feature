Feature: Show the list of bank transactions
  Scenario: No filters, and transactions exist
    Given the user has a list of "bank transactions"
    And the user is on the "bank transactions" page
    Then the user sees the "description" of every "bank transaction"
    And the user sees the "posted at" of every "bank transaction"
    And the user sees the "total" of every "bank transaction"

  Scenario: No data exists
    Given the user is on the "bank transactions" page
    Then the user should see "No transactions available"
