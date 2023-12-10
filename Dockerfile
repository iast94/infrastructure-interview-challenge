FROM node:21-alpine3.18 as builder

WORKDIR /app

COPY . .

RUN yarn install

RUN yarn build

FROM node:21-alpine3.18

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

WORKDIR /app

COPY --chown=appuser:appgroup package.json yarn.lock /app/

COPY --from=builder --chown=appuser:appgroup /app/dist /app/src

RUN yarn install --production

CMD [ "yarn", "start" ]
