#base
FROM alpine:3.7

#getting bash
RUN apk update && apk add bash && apk add make && apk add libc6-compat && apk add libstdc++

#copying rMutant
COPY /multiMutant_image/ /usr/multiMutant/

#
WORKDIR /usr/multiMutant
ENTRYPOINT ["/usr/multiMutant/multimut.sh"]
