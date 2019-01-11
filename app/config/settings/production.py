from .base import *

PRODUCTION_JSON = json.load(open(os.path.join(SECRET_DIR, 'production.json')))

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    '127.0.0.1',
    'localhost',
]

STATIC_ROOT = os.path.join(ROOT_DIR, '.static')

WSGI_APPLICATION = 'config.wsgi.production.application'


# Database
# https://docs.djangoproject.com/en/2.1/ref/settings/#databases

DATABASES = PRODUCTION_JSON['DATABASES']