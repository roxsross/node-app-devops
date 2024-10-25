FROM node:21-alpine
ENV NODE_ENV=uat
ENV PORT=3000
WORKDIR /usr/src/app
COPY ./ /usr/src/app/
#RUN npm install --production
RUN lala
EXPOSE 3000
CMD ["sh", "-c", "date ; npm start "]

#byRoxsRoss!
