
# install from github kollava
FROM movie5/kollava:0.8
LABEL AUTHOR Younghwa Oh (oyh5800@gmail.com)

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR /home/KoLLaVA

# Install pip requirements
RUN pip install --upgrade 
RUN apt-get -y update && apt -get install -y \
nginx\
git\
pydantic==1.8.0\
starlette

#Locale
RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8
ENV PYTHONIOENCODING=utf-8
ENV PORT=7777

EXPOSE 7777
