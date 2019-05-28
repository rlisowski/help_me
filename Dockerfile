FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler
RUN mkdir /help_me
WORKDIR /help_me
COPY Gemfile /help_me/Gemfile
COPY Gemfile.lock /help_me/Gemfile.lock
RUN bundle install
COPY . /help_me

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
