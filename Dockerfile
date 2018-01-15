
# entando-builder
FROM pmasala/entando-base-image-432

MAINTAINER Pietrangelo Masala <p.masala@entando.com>

ENV ENTANDO_VERSION=4.3.2

LABEL io.k8s.description="Entando builder image based on 4.3.2 release" \
      io.k8s.display-name="entando 4.3.2" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="entando,ux-convergence,openshift" \
      io.openshift.s2i.scripts-url=image:///usr/local/s2i

# TODO: Install required packages here:

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/local/s2i
COPY filter-development-unix.properties /opt/entando/

# Drop the root user and make the content of /opt/app-root owned by user 1001
USER root
RUN chgrp -R 0 /opt/entando/ && chmod -Rf g=u /opt/entando/

WORKDIR /opt/entando/

# This default user is created in the openshift/base-centos7 image
USER 10001

EXPOSE 8080

CMD ["/usr/local/s2i/usage"]
