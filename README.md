# docker pulseway

Run Pulseway as a docker container to get notified when the server goes down

## Setup

1. Copy the [.env.sample](./.env.sample) file to [.env](./.env) and update the variables

1. Copy the [config.xml.sample](./config.xml.sample) file to [config.xml](./config.xml)

1. Run the `./download-latest.sh` script

1. Add the downloaded Pulseway filename to the top of the [Dockerfile](./build/Dockerfile)

1. Run `docker-compose down && docker-compose up --build -d && docker-compose logs -f`
