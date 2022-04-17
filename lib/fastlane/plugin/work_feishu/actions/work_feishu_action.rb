require 'fastlane/action'
require_relative '../helper/work_feishu_helper'

module Fastlane
  module Actions
    class WorkFeishuAction < Action
      require 'net/http'
      require 'net/https'
      require 'json'

      def self.run(params)
        UI.message("The work_feishu plugin is working!")
        webhook = params[:webhook_URL]
        puts "webhook = #{webhook}"
        url = URI(webhook)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true if url.scheme == 'https'

        headers = { 'Content-Type' => 'application/json' }
        request = Net::HTTP::Post.new(url, headers)
        
        if params[:text_content]
          request.body = text_http_body(params)
        end

        puts http.request(request).body

      end

      def self.text_http_body(params)
        content = params[:text_content]
        body = {}
        body['msg_type'] = "text"
        
        # 1、文本类型
        # {
        #   "msgtype": "text",
        #   "content": {
        #       "text": "广州今日天气：29度，大部分多云，降雨概率：60%",
        #   }
        # }

        text = { 'text' => content }
        body['content'] = text
        body.to_json
      end


      def self.description
        "work feishu webhook"
      end

      def self.authors
        ["sunfjun"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "work feishu webhook"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :webhook_URL,
                                description: "机器人的webhook地址",
                                  optional: false,
                                      type: String),

          FastlaneCore::ConfigItem.new(key: :text_content,
                                        description: "文本内容，最长不超过2048个字节，必须是utf8编码",
                                           optional: true,
                                               type: String),
         
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "WORK_FEISHU_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
