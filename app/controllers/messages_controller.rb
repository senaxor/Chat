class MessagesController < ApplicationController
    def create
        @current_user = current_user
        is_valid_message = message_validator(msg_params[:content], current_user)

        if is_valid_message
          @message = @current_user.messages.create(content: msg_params[:content], room_id: params[:room_id])
        end
      end
    
      private

      def message_validator(message_item, current_user)
        pure_content = message_item&.strip
        return false if pure_content.nil?

        last_message_hour = current_user.messages&.last&.created_at&.hour
        last_message_minutes = current_user.messages&.last&.created_at&.min
        last_message_seconds = current_user.messages&.last&.created_at&.sec
        
        now_hours = Time.zone.now.hour
        now_minutes = Time.zone.now.min
        now_seconds = Time.zone.now.sec

        return true if last_message_hour.nil? || last_message_minutes.nil? || last_message_seconds.nil?

        return false if (last_message_hour == now_hours) and (last_message_minutes == now_minutes) and (last_message_seconds == now_seconds)

        return true
      end
      
      def msg_params
        params.require(:message).permit(:content)
      end
end
