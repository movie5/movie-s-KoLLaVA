# 
FROM python:3.11
 
# /code 폴더 만들기 
WORKDIR /tmp

# /poetry
RUN pip install poetry

# 
COPY ./pyproject.toml ./poetry.lock* /tmp/

# 
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

# 
FROM python:3.9

# 
WORKDIR /code

# 
COPY --from=requirements-stage /tmp/requirements.txt /code/requirements.txt

# requirements.txt를 보고 모듈 전체 설치 (-r)
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# code/app에 복사
COPY ./app /code/app

# 실행 
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
