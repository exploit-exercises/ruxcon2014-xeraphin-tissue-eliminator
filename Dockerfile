FROM fedora:latest
RUN yum upgrade -y || true
RUN yum groupinstall -y "C Development Tools and Libraries"
RUN yum install -y rubygem-bundler libsqlite3x-devel ruby-devel make patch automake autoconf 
RUN yum install -y vim-common nano
RUN yum install -y perl-devel perl-App-cpanminus
WORKDIR /app
ADD . /app
RUN cpanm Test::More
RUN cpanm --installdeps .
USER 65521:65521
EXPOSE 65521
CMD [ "perl", "app.pl", "daemon", "--listen", "http://*:65521" ]
