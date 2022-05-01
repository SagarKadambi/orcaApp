#!/bin/sh
pipenv install psycopg2-binary
# migrate the database
pipenv run flask db init
pipenv run flask db revision --rev-id b7a1d28e08d0
pipenv run flask db revision --rev-id b6bd18b9ebe7
pipenv run flask db migrate
pipenv run flask db upgrade

# run the app
exec pipenv run python app.py
