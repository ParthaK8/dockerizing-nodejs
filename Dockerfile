# Dockerfile

FROM node:12.13.0-alpine
RUN apk add --no-cache bash git zip curl wget ca-certificates
RUN mkdir -p /opt/app
WORKDIR /opt/app
RUN adduser --disabled-password app
COPY addressbook/ .
RUN npm install
RUN chown -R app:app /opt/app
USER app
EXPOSE 3000
CMD [ "npm", "run", "pm2" ]