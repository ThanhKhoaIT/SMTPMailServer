require 'midi-smtp-server'
require 'mail'

class MySmtpd < MidiSmtpServer::Smtpd

  def on_message_data_event(ctx)
    logger.debug("[#{ctx[:envelope][:from]}] for recipient(s): [#{ctx[:envelope][:to]}]...")

    @mail = Mail.read_from_string(ctx[:message][:data])

    logger.debug('------------------------')
    logger.debug(@mail.subject)
    logger.debug(@mail.html_part.body.to_s.unpack("M").first)
    logger.debug('------------------------')
  end

end

server = MySmtpd.new('2525', '127.0.0.1, ::1')
server.start
server.join
