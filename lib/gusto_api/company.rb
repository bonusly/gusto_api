module GustoApi
  class Company
    def self.create(user:, company:)
      raise Error.new("Missing a required attribute") unless user[:first_name] && user[:last_name] && user[:email] && company[:name]

      Request.new(
        endpoint: 'provision',
        method: :post,
        params: { user: user, company: company }
      ).submit
    end

    def initialize(id, access_token)
      self.id = id
      self.access_token = access_token
    end

    def employees(include_terminated: false)
      params = include_terminated ? {} : { terminated: false }
      Request.new(
        endpoint: "companies/#{id}/employees",
        method: :get,
        params: params
      )
    end

    private

    attr_accessor :id, :access_token
  end
end
