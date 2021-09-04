FROM node

RUN apt update && \
    apt install -y git

RUN git clone https://github.com/simplicitesoftware/nodejs-demo

ENV PORT=3000 VCAP_APP_HOST=0.0.0.0
EXPOSE 3000

WORKDIR /nodejs-demo
RUN npm install

ENTRYPOINT ["npm", "start"]