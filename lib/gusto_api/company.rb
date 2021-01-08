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
  end
end
