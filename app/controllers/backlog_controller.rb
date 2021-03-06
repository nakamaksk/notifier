class BacklogController < ApplicationController

  def bug_report
    content  = params.require(:content).permit!
    issue_type = content[:issueType]
    changes = content[:changes]&.first || {} # 配列の最初の要素にある

    if changes[:field] == "status" &&
      changes[:new_value] == "4" &&
      issue_type[:id].to_s == ENV['BACKLOG_ISSUE_TYPE_ID'].to_s
      # 完了ステータスに更新された時だけチャットに通知
      updated_info = GoogleChat.body(content)
      GoogleChat.post(updated_info)

      # Slackに不具合の件数を通知
      bug_info = Backlog::Issue::Bug.report
      Slack.post(updated_info << bug_info)
    end

    # TODO:課題登録時にGoogolChatに通知する
    if false
      created_message = GoogleChat.created_message
      GoogleChat.post(created_message)
    end
  end

  private

end
