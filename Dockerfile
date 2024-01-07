#Pull base node image from docker registry & define multi-build
FROM node:latest as artifact
WORKDIR /app
COPY . /app
RUN npm install --silent
RUN npm install react-scripts@5.0.1 -g --silent
COPY . /app
RUN npm run build

#Pull base nginx image from docker registry
FROM nginx:latest
WORKDIR /usr/share/nginx/html

#copy artifact from node to nginx

COPY --from=artifact /app/build /usr/share/nginx/html
EXPOSE 9001
CMD ["nginx","-g","daemon off;"]
