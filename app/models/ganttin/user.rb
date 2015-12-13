module Ganttin
  class User < ActiveRecord::Base
    self.table_name = :users

    has_many :project_members
    has_many :projects, through: :project_members
    has_many :task_members
    has_many :tasks, through: :task_members
    has_many :time_entries

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable,
           :timeoutable, :lockable

    validates :email, uniqueness: true, email: { mx: true }, if: -> { email.present? }

    before_save :ensure_authentication_token

    has_unique_identifier :id, length: 16, no_symbols: true

    def access_token
      authentication_token
    end

    def access_token=(token)
      self.authentication_token = token
    end

    def reset_authentication_token!
      self.authentication_token = generate_authentication_token
      save
    end

    private

    def ensure_authentication_token
      self.authentication_token ||= generate_authentication_token
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless self.class.where(authentication_token: token).first
      end
    end
  end
end
