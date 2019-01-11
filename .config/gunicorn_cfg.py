import multiprocessing

bind = 'unix:/tmp/gunicorn.sock'
workers = multiprocessing.cpu_count() * 2 + 1
errorlog = '/var/log/gunicorn_errors.log'
