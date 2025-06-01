module RedisModule
  extend ActiveSupport::Concern

  included do

    def r_connect
      Redis.new(db: 0)
    end

    def r_delete_remember_token_user
      r_connect.del(current_user.remember_token_digest)
    end
  end
end