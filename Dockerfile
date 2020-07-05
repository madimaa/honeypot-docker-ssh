FROM debian:buster-20200607-slim

RUN apt update && apt install --yes git python2.7 python-pip

RUN echo Port 5050 >> /etc/ssh/sshd_config

RUN mkdir /work
WORKDIR /work

RUN git clone https://github.com/regit/pshitt.git

WORKDIR /work/pshitt

RUN pip install paramiko python-daemon

EXPOSE 22

CMD ["./pshitt.py", "-o", "/out/passwords.json", "-p", "22"]
