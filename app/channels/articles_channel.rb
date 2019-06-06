# frozen_string_literal: true

class ArticlesChannel < ApplicationCable::Channel
  # Called when the consumer has successfully
  # become a subscriber to this channel.
  def subscribed
    stream_for 'articles'
  end
end
