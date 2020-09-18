FROM centos:7 as build
RUN rpm -qa | grep "libxml2"
COPY ./testlibxml.py /tmp/testlibxml.py
RUN python /tmp/testlibxml.py 

FROM bsalunke/centos:7_without_libxml2
COPY ./testlibxml.py /tmp/testlibxml.py
RUN rpm -qa | grep "libxml2"
RUN python /tmp/testlibxml.py; exit 0
COPY --from=build /usr/lib64/libxml2.so.2.9.1 /usr/lib64/libxml2.so.2.9.1
COPY --from=build /usr/lib64/libxml2.so.2 /usr/lib64/libxml2.so.2
RUN rpm -qa | grep "libxml2"
RUN python /tmp/testlibxml.py
