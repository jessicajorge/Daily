class User < ApplicationRecord
    validates_presence_of :name, :email, :team_id
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    belongs_to :team
    has_one :team, foreign_key: "team_id"
end
