FROM        ecs-deploy:base

COPY        ./ /srv/projects

WORKDIR     /srv/projects/app
RUN         python3 ./manage.py collectstatic --noinput

RUN         rm -rf /etc/nginx/sites-enabled/* && \
            rm -rf /etc/nginx/sites-available/* && \
            cp -f /srv/projects/.config/app.nginx /etc/nginx/sites-available/ && \
            ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx

RUN         cp -f /srv/projects/.config/supervisord.conf /etc/supervisor/conf.d/
CMD         supervisord -n