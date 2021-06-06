# named builder (AWS requires unnamed builders to deploy via docker)
FROM node:14-alpine as builder
WORKDIR /usr/app

COPY package.json .
RUN yarn install
COPY . .
# is built into usr/app/build folder
RUN yarn build

FROM nginx
# EXPOSE instruction is only relevant for AWS elastic-beanstalk; locally it doesn't do anything
# EXPOSE tells elastic-beanstalk to listen for incoming traffic on port 80, 
# which is where nginx is serving the build folder by default (nginx default port is 80)
EXPOSE 80
COPY --from=builder /usr/app/build /usr/share/nginx/html