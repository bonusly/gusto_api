module GustoApi
  class Company
    def self.create(user:, company:)
      raise Error.new("Missing a required attribute") unless user[:first_name] && user[:last_name] && user[:email] && company[:name]

      TokenRequest.new(
        endpoint: 'v1/provision',
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
      BearerRequest.new(
        endpoint: "v1/companies/#{id}/employees",
        method: :get,
        params: params,
        auth_token: access_token
      ).submit
    end

    private

    attr_accessor :id, :access_token
  end
end
