FROM python
RUN apt-get update && apt-get upgrade -y
SHELL ["/bin/bash", "-c"]
RUN mkdir  /code
COPY . /code/
WORKDIR /code/chatproject/
RUN mv ./django_config.json /etc 
RUN python -m pip install --upgrade pip && \        
      pip install virtualenv && virtualenv ./venv && \
        source ./venv/bin/activate && \
            pip install -r requirements.txt && \
                python manage.py collectstatic
CMD source ./venv/bin/activate && python manage.py makemigrations &&\
      python manage.py migrate && python manage.py runserver 0.0.0.0:9000
