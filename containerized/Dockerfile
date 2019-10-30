#base
FROM ubuntu:19.10

#getting bash
RUN apt-get update && apt-get install libstdc++5
#copying rMutant
COPY /multiMutant_image/ /usr/multiMutant/

#
WORKDIR /usr/multiMutant
ENTRYPOINT ["/usr/multiMutant/multimut.sh"]
