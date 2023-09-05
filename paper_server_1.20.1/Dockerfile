FROM docker.io/redhat/ubi9-minimal

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV PATH=/opt/graalvm-jdk-17.0.8+9.1/bin:$PATH
ENV JAVA_HOME=/opt/graalvm-jdk-17.0.8+9.1

RUN microdnf install -y binutils tzdata openssl wget ca-certificates fontconfig glibc-langpack-en gzip tar \
    freetype dejavu-sans-mono-fonts && microdnf clean all

RUN curl -L https://download.oracle.com/graalvm/17/latest/graalvm-jdk-17_linux-x64_bin.tar.gz | tar -zxvC /opt/

RUN mkdir /app \
    && curl -L https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/170/downloads/paper-1.20.1-170.jar -o /app/paper-1.20.1.jar

RUN echo "eula=true" > /app/eula.txt

WORKDIR /server
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]