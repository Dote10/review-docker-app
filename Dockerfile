FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY ./ ./

RUN npm run build

# build stage

FROM nginx

COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# run stage : nginx를 실행 시키는 것이 목표
# builder stage에서 생성된 /usr/src/app/build를 nginx가 실행되는 /usr/share/nginx/html에 복사