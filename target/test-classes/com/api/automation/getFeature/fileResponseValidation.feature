Feature: Validating response with external files

  Background: Defining the basepath
    Given url 'http://localhost:8080'

  Scenario: Validating response from JSON
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    #And print response
    * def expectedResponse = read("../JSONresponse.json")
    And match response == expectedResponse
    And print expectedResponse
