module Responses::Tag
  extend ActiveSupport::Concern
  included do

    acts_as_api

    api_accessible :default do |t|
      t.add :id
      t.add :name
    end

  end
end
