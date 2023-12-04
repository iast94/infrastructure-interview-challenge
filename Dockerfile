FROM node:21-alpine3.18 as builder

WORKDIR /app

COPY . .

RUN yarn install

RUN yarn build

FROM node:alpine

WORKDIR /app

COPY package.json yarn.lock /app/

COPY --from=builder /app/dist /app/src

RUN yarn install --production

CMD [ "yarn", "start" ]
