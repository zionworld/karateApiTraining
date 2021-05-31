Feature: To test the get endpoint of the application
  All get endpoints will be testing in this feature

  Background: setup the Base Path
    Given url 'http://localhost:8080'
    And print "====================This is the background=========================="

  Scenario: List the users for a specific page 2 as query parameter and response in JSON format
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response

  Scenario: List the users for a specific page 2 as query parameter and response in xml format
    And path '/laptop-bag/webapi/api/find/127'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And print response

  Scenario: List the users and validate the complete JSON response
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response ==
      """
       [{
          "BrandName": "Apple",
          "Features": {
            "Feature": [
              "8GB RAM",
              "1TB Hard Drive",
              "250 GB of 550",
              "15.5 inc Display",
              "USB 3.0"
            ]
          },
          "Id": 127,
          "LaptopName": "Mac Book Pro"
        }]

      """

  Scenario: List the users and validate Id
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response contains deep {"Id":127}

  Scenario: List the users and validate LaptopName
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response contains deep {"LaptopName":"Mac Book Pro"}

  Scenario: List the users and validate 1TB Hard Drive
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response contains deep {"Features":{"Feature":"1TB Hard Drive"}}

  Scenario: List the users and validate Response Header
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match header Content-Type == 'application/json'

  Scenario: List the users and validate response using JSON path and wildcards
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.[0].Id == 127
    And match response.[0].Features.Feature[2] == '250 GB of 550'
    And match response.[0].Features.Feature[*] contains '15.5 inc Display'
    And match response.[0].Features.Feature[*] contains ["8GB RAM","1TB Hard Drive"]
    And match response.[0].LaptopName == 'Mac Book Pro'

  Scenario: List the users and validate response using XPATH path and wildcards
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And match response/laptopDetailss/Laptop/Id == '127'
    And match response/laptopDetailss/Laptop/Features/Feature[3] == '250 GB of 550'
    And match response/laptopDetailss/Laptop/Features/Feature contains '15.5 inc Display'
    And match response/laptopDetailss/Laptop/Features/Feature contains ["8GB RAM","1TB Hard Drive"]
    And match response/laptopDetailss/Laptop/LaptopName == 'Mac Book Pro'
    And match response/laptopDetailss/Laptop/Features/Feature == '#[] #string? _.length>=2'

  Scenario: List the users and validate response using JSON path and fuzzymatcher
    And path '/laptop-bag/webapi/api/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response.[0].Id == 127
    And match response.[0].Features.Feature[2] == '#present'
    And match response.[0].Features.Feature == '#notnull'
    And match response.[0].Features.Feature == '#array'
    And match response.[0].LaptopName == '#string'
    And match response.[0].Features.Feature == '#[] #string? _.length>=2'
