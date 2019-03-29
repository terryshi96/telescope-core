FROM ruby:2.5.0-slim-stretch
ENV HOME /app
ENV RAILS_ENV production
RUN echo "deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get install -y build-essential openssh-server git libpq-dev nodejs curl cron openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && \
    mkdir $HOME
WORKDIR $HOME
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN whenever --update-crontab
#RUN bin/rails db:migrate
CMD cron && puma -C config/puma.rb