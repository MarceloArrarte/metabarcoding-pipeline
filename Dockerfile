FROM ubuntu:24.04 AS prueba

WORKDIR /usr/src

RUN apt-get update && \
    apt install zip unzip curl bash dos2unix --assume-yes

RUN curl -s https://get.sdkman.io | bash

ENV PATH="$HOME/.sdkman/bin:$PATH"

# RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
#     sdk install java 17.0.10-tem && \
#     JAVA_HOME=$(sdk home java 17.0.10-tem)"

RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install java 17.0.10-tem && \
    sdk default java 17.0.10-tem"


ENV JAVA_HOME="$HOME/.sdkman/candidates/java/current"
ENV PATH="$JAVA_HOME/bin:$PATH"

FROM prueba AS development

RUN bash -i -c "cat ~/.bashrc && \
    echo $PATH && \
    echo \"JAVA HOME: $JAVA_HOME\" && \
    java -version"

RUN bash -i -c "curl -s https://get.nextflow.io | bash"

RUN bash -i -c "chmod +x nextflow && \
    mv nextflow /usr/local/bin && \
    nextflow info"

ENV NXF_VER=22.10.8

RUN bash -i -c "nextflow run hello"

COPY environment_setup.sh ./

RUN bash -i -c "sed -i 's/\r//' environment_setup.sh && \
    sed -i 's/^sudo //' environment_setup.sh && \
    bash environment_setup.sh"


# FROM development AS production

COPY ./nanoclust ./pipeline

# RUN find . -name 'pipeline/templates/*.py' -print0 | xargs -0 dos2unix
RUN find . -name 'pipeline/*' -print0 | xargs -0 dos2unix

WORKDIR /usr/src/pipeline

ENTRYPOINT [ "/bin/bash" ]

CMD [ "run_main.sh" ]