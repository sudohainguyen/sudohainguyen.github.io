FROM jekyll/jekyll

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --quiet --clean

EXPOSE 80
CMD ["jekyll", "serve"]
