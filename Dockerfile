FROM node:12.18.1
WORKDIR /usr/src/app
COPY ./package*.json server.js ./
RUN npm install
EXPOSE 80:3000
CMD [ "node", "server.js" ]
