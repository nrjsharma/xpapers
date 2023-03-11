# Xpapers

### Install

```shell
# create env
pyenv virtualenv 3.8.0 xpapers
# enable env
pyenv activate xpapers
# install requirements
pip install -r requirements.txt
```

### Run Locally

```shell
# run migrations
python manage.py migrate
# run server
python manage.py runserver 0:8000
```