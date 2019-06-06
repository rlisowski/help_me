# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TranslateArticleJob, type: :job do
  let(:article_id) { SecureRandom.uuid }

  it 'calls Translator service with correct params' do
    translator_instance = double
    expect(Translator).to receive(:new).with(article_id).and_return(translator_instance)
    expect(translator_instance).to receive(:call)

    TranslateArticleJob.perform_now(article_id)
  end
end
