class Helpers

    @@item = nil

    def self.item=(item)
        @@item = item
    end

    def self.item
        @@item = item
    end

    def self.user(session)
        User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
        true if (session[:user_id].is_a? Integer) && session[:user_id] > 0
    end
end