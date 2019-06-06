# Help Me

**_Help Me_** app helps build a knowledge base in English and automatically translate it to German.

![Help Me app screenshot](doc/Help_Me.jpg)

## Development

Install [Docker](https://www.docker.com/) and execute `$ MICROSOFT_TRANSLATOR_API_KEY='KEY' docker-compose up` in terminal emulator to run the app locally. Visit http://localhost:4000 to see it.

###  Development without Docker

#### Install all dependencie

`$ brew install ruby`
`$ brew install postgresql`
`$ brew install redis`

#### Setup the application

`$ MICROSOFT_TRANSLATOR_API_KEY='KEY' bundle exec bin/setup`

#### Run the application

`$ MICROSOFT_TRANSLATOR_API_KEY='KEY' bundle exec rails server`
