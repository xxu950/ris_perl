FROM perl:slim-threaded

RUN apt-get update && apt-get install -y --no-install-recommends git && apt-get clean
