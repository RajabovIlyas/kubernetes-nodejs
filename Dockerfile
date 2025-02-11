FROM node:23-alpine3.20 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:23-alpine3.20 as runner

WORKDIR /app

COPY --from=build /app/dist ./dist
COPY package*.json ./

RUN npm install --only=production

ENV NODE_ENV="producton"
ENV PORT=3000

EXPOSE 3000

CMD ["node", "dist/index.js"]