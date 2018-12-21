#build phase
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN ["npm", "run", "build"]

#run phase

#/app/build will contain all the files we need for the "run" phase
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
