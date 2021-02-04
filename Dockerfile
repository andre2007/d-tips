FROM ubuntu:focal

RUN apt update && apt install -y python3 python3-pip

# Prebuild requirements
COPY requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt

# COPY output/ /tmp
WORKDIR /output
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]