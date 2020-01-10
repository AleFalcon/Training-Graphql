#!/bin/sh

# Move this file to .git/hooks
# Remember to execute chmod +x

echo "\033[34mRunning Rspec tests\033[0m"
RUN_CHECK_CMD='bundle exec rspec spec -fd'
RUN_TESTS_OUTPUT=`${RUN_CHECK_CMD}`

if [ $? -eq 1 ]
then
  echo "\033[34mCan't commit! You've broken Rspec tests!!!\033[0m"
  exit 1
fi

echo "\033[34mRunning Rubocop\033[0m"
RUN_CHECK_CMD='bundle exec rubocop app spec --format simple'
RUN_TESTS_OUTPUT=`${RUN_CHECK_CMD}`

if [ $? -eq 1 ]
then
  echo "\033[34mCan't commit! You have Rubocop offences!!!\033[0m"
  exit 1
fi

echo "\033[34mRunning Brakeman\033[0m"
RUN_CHECK_CMD='bundle exec brakeman -q --no-summary'
RUN_TESTS_OUTPUT=`${RUN_CHECK_CMD}`

if [ $? -eq 1 ]
then
  echo "\033[34mCan't commit! You have Brakeman offences!!!\033[0m"
  exit 1
fi

echo "\033[34mRunning bundler-audit\033[0m"
RUN_CHECK_CMD='bundle exec bundle audit check --update --quiet'
RUN_TESTS_OUTPUT=`${RUN_CHECK_CMD}`

if [ $? -eq 1 ]
then
  echo "\033[34mCan't commit! You have bundler-audit offences!!!\033[0m"
  exit 1
fi

echo "\033[34mRunning RubyCritic\033[0m"
RUN_CHECK_CMD='bundle exec rubycritic --minimum-score 80 --no-browser'
RUN_TESTS_OUTPUT=`${RUN_CHECK_CMD}`

if [ $? -eq 1 ]
then
  echo "\033[34mCan't commit! You have RubyCritic offences!!!\033[0m"
  exit 1
fi

echo "\033[34mAll checks passed. You didn't break anything. Congrats!\n\033[0m"
exit 0
