module Lita
  module Handlers
    class WeeklyReview < Handler
      route(/^weekly_review\s+(.+)/, :weekly_review, command: true)

      JENKINS_BUILD_URL = 'http://manage.kurorekishi.me/jenkins/job/%s/buildWithParameters?YEAR=%s&WEEK_NUM=%s'
      REQUEST_COMMAND   = "curl -sS -X POST --user #{ENV['JENKINS_REQUEST_TOKEN']} '#{JENKINS_BUILD_URL}'"
      JENKINS_WEEKLY_REVIEW_JOBS = {
        read:         'WeeklyReview Reading Books',
        iteration:    'WeeklyReview PivotalTracker Iteration',
        commit:       'WeeklyReview Github Commit',
        pull_request: 'WeeklyReview Github Pull Request',
        body_metrics: 'WeeklyReview Body Metrics',
      }

      def weekly_review(response)
        report_type, year, week_num = response.matches[0][0].split
        job_name = JENKINS_WEEKLY_REVIEW_JOBS[report_type.to_sym]
        if job_name.present?
          %x{ #{REQUEST_COMMAND % [URI.escape(job_name), year, week_num]} }
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
