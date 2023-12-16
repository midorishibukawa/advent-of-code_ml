FROM alpine:latest
COPY advent_of_code /advent_of_code
EXPOSE 8080
CMD [ "sh", "-c", "/advent_of_code" ]
