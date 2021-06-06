# named builder (AWS requires unnamed builders to deploy via docker)
FROM node:14-alpine as builder
WORKDIR /usr/app

COPY package.json .
RUN yarn install
COPY . .
# is built into usr/app/build folder
RUN yarn build

FROM nginx
COPY --from=builder /usr/app/build /usr/share/nginx/html