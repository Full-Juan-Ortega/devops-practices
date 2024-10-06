
FROM node:14-alpine
WORKDIR /usr/src/app
EXPOSE 3001
COPY ./package*.json ./
RUN npm install
COPY ./src ./src
ENV API_URL="https://api.backendapp.com/v1"
USER node
CMD ["npm", "start"]
