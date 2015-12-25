module Lita
  module Handlers
    class WeeklyReview < Handler
      route(/^weekly_review\s+(.+)/, :weekly_review, command: true)

      JENKINS_BUILD_URL = 'http://manage.kurorekishi.me/jenkins/job/WeeklyReview/buildWithParameters?REPORT_TYPE=%s&YEAR=%s&WEEK_NUM=%s'
      REQUEST_COMMAND   = "curl -sS -X POST --user #{ENV['JENKINS_REQUEST_TOKEN']} '#{JENKINS_BUILD_URL}'"
      JENKINS_WEEKLY_REVIEW_JOBS = %w(read iteration commit pull_request body_metrics)

      def weekly_review(response)
        report_type, year, week_num = response.matches[0][0].split
        if JENKINS_WEEKLY_REVIEW_JOBS.include?(report_type)
          %x{ #{REQUEST_COMMAND % [report_type, year, week_num]} }
          message = "(○´―`)ゞ"
        else
          message = "(๑˙−˙๑)？ *#{__method__} #{report_type}*"
        end
        response.reply(message)
      rescue => ex
        message = "(இдஇ; ) #{ex.message}"
        response.reply(message)
      end
    end
  end
end
