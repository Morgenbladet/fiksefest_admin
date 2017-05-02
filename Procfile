web: bundle exec puma -C config/puma.rb
resque: env TERM_CHILD=1 QUEUE=paperclip bundle exec rake resque:work
