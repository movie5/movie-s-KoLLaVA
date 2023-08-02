# install from github kollava
FROM ubuntu:latest
LABEL AUTHOR Younghwa Oh (oyh5800@gmail.com)

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR mkdir /app
WORKDIR /app


# Install pip requirements

RUN apt-get -y update && apt -get install -y \
nginx\
git\
pydantic==1.8.0\
starlette \
python3.10 \
pip

COPY pyproject.toml /app/pyproject.toml
RUN pip install --upgrade pip
RUN pip install -e .

#Locale
RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8
ENV PYTHONIOENCODING=utf-8
ENV PORT=7777

EXPOSE 7777


