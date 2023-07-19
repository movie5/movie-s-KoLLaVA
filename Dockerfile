# 
FROM python:3.11
 
# /code ���� ����� 
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

# requirements.txt�� ���� ��� ��ü ��ġ (-r)
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# code/app�� ����
COPY ./app /code/app

# ���� 
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
