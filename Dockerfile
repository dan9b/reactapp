#start with the base image 
FROM node:alpine as build-phase

#Define the user directory 
WORKDIR '/app'

#COPY the most important file 
COPY ./package.json .

#RUN the command to install all the pre-reqs
RUN npm install 

#COPY All other source file 
COPY . .

#Note we wDefine the start-up command 
RUN npm run build 

#note content of the this command would be written in WORKDIR/build i.e. app/build 

FROM nginx as runtime-phase 

#copy the content from build phase container dir "/app/build" to "/usr/share/nginx/html"
COPY --from=build-phase /app/build /usr/share/nginx/html

