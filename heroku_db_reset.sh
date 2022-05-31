#!/bin/bash
heroku login
wait
heroku restart -a todo-api-korzhov
wait
heroku pg:reset DATABASE --confirm todo-api-korzhov -a todo-api-korzhov
wait
heroku run rake db:migrate -a todo-api-korzhov
wait
heroku run rake db:seed -a todo-api-korzhov
