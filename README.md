# docker pulseway

Run Pulseway as a docker container to get notified when the host goes down

## Setup

1. Clone this repo

1. Copy the [.env.sample](./.env.sample) file to [.env](./.env) and update the variables

1. Copy the [config.xml.sample](./config.xml.sample) file to [config.xml](./config.xml)

1. Run `docker-compose down && docker-compose up --pull -d && docker-compose logs -f`
