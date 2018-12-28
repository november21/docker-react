#build phase
FROM node:alpine as builder

WORKDIR '/app'

COPY package*.json ./

RUN npm install

COPY . .

RUN ["npm", "run", "build"]

#run phase

#/app/build will contain all the files we need for the "run" phase
FROM nginx

EXPOSE 80 
#AWS elastic beanstalk requires us to provide a port

COPY --from=builder /app/build /usr/share/nginx/html
