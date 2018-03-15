module Alexa
  module IntentHandlers
    class NextMeetups < Alexa::IntentHandlers::Base
      def handle
        if slots["Topic"].value.nil? || slots["Topic"].bad_match?
          response.elicit_slot!("Topic")
        end
        response
      end



      # Methods to fetch meetups JSON
      def meetups
        @meetups ||= begin
                       uri = URI("https://api.meetup.com/#{urlname_for(slots["Topic"].value)}/events")
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
