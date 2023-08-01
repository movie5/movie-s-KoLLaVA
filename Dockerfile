
# install from github kollava
FROM movie5/kollava:0.8

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
RUN pip install --upgrade 
RUN apt-get -y update && apt -get install nginx

EXPOSE 7777

ENTRYPOINT /home/KoLLaVA
