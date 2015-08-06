Feature: Doc generation from Rails request specs
  Background:
    Given I am currently in my example Rails-app

  Scenario: A request spec with a GET request
    Given a file named "spec/requests/posts_requests_spec.rb" with the contents:
      """
      require 'rails_helper'

      RSpec.describe "Posts REST API", type: :request do
        describe "GET /posts" do
          it "returns all posts" do
            get posts_path
            expect(response).to have_http_status(200)
          end
        end
      end
      """
    When I run `rspec`
    Then all tests should pass
    And a file should exist at "docs/requests/posts_requests.md" with the contents:
      """
      # Posts REST API

      ## GET /posts

      ### It returns all posts

      1. Request:

         ```
         GET /fishbrain/rutilus-api HTTP/1.1
         Host: example.com
         Connection: keep-alive
         ```

         Response:

         ```
          HTTP/1.1 200 OK
          Server: example.com
          Date: Thu, 06 Aug 2015 14:57:26 GMT
          Content-Type: application/json; charset=utf-8

          [
            {
              "id": 1,
              "title": "My title",
              "body": "My body"
            }
          ]
         ```
      """