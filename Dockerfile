#Specify Base Image
FROM node:alpine as builder
#WorkDir
WorkDir /app
# Install dependencies
# Copying the files for node js
# Breaking into 2 steps since we want Docker to use the cache version for dependencies.
#COPY ./package.json ./
#AWS changes
COPY package*.json ./
RUN npm install
# Copying rest of the files.
COPY ./ ./
# Default Command
#CMD ["npm","run","build"]
RUN npm run build

FROM nginx
#Added Expose
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
