#
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
#


FROM nimmis/java-centos:openjdk-8-jdk

# install streamsets datacollector
RUN yum -y update; yum clean all; yum install -y https://archives.streamsets.com/datacollector/1.2.1.0/rpm/streamsets-datacollector-1.2.1.0-1.noarch.rpm;

# create links to config files
RUN mkdir /opt/streamsets-datacollector/etc && ln -s /etc/sdc/sdc-security.policy /opt/streamsets-datacollector/etc/sdc-security.policy && ln -s /etc/sdc/sdc.properties /opt/streamsets-datacollector/etc/sdc.properties

# Disable authentication by default, override with custom sdc.properties
RUN sed -i 's|\(http.authentication=\).*|\1none|' "/etc/sdc/sdc.properties"

EXPOSE 18630

COPY start-sdc.sh /tmp/start-sdc.sh

# make start script executable
RUN chmod 0755 /tmp/start-sdc.sh

ENTRYPOINT [ "/tmp/start-sdc.sh" ]
