module Alexa
  module IntentHandlers
    class NextMeetups < Alexa::IntentHandlers::Base
      def handle
        if slots["Type"].value.nil? || slots["Type"].bad_match?
          response.elicit_slot!("Type")
        end
        response
      end

      def meetups
        @meetups ||= begin
                       uri = URI("https://api.meetup.com/#{urlname_for(slots["Type"].value)}/events")
                       resp = Net::HTTP.get(uri)
                       JSON.parse(resp).first(2)
                     end
      end

      private

      def urlname_for(type)
        return "Munich-Rubyshift-Ruby-User-Group" if type == "ruby"
        return "Munich-Startup-Founder-101" if type == "startup"
      end
    end
  end
end
