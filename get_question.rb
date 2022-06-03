require "httparty"
require "json"
module GetService
    class Question
        include HTTParty
        base_uri "https://opentdb.com/api.php?"
    def self.get_question(id, difficulty)
        random = "difficulty=#{difficulty}"
        selected = "category=#{id}&difficulty=#{difficulty}"
        response = id.zero? ? get("amount=10&#{random}") : get("amount=10&#{selected}")
        raise HTTParty::ResponseError, response unless response.success?
        JSON.parse(response.body, symbolize_names: true)
    end
    end
end