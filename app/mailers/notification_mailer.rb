class NotificationMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def notification_email(user)
        @noti = "Comment created"
        mail(to: user.email, subject: 'comment created',template_path: 'notification_mailer', template_name: 'notification')
    end

    def followed_email(user)
        @noti = "Follower gained"
        mail(to: user.email, subject: 'Follower',template_path: 'notification_mailer', template_name: 'following')
    end
    def unfollowed_email(user)
        @noti = "Follower lost"
        mail(to: user.email, subject: 'Follower',template_path: 'notification_mailer', template_name: 'following')
    end
end
