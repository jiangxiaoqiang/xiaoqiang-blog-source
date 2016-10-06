---
title: ambari-install-error
tags:
---

```
Could not determine HDP version for component zookeeper-server by calling '/usr/bin/hdp-select status zookeeper-server > /tmp/tmpLc7S7k'. Return Code: 1
```

```
raise Fail("Applying %s failed, parent directory %s doesn't exist" % (self.resource, dirname))
resource_management.core.exceptions.Fail: Applying File['/usr/hdp/current/hadoop-client/conf/hadoop-policy.xml'] failed, parent directory /usr/hdp/current/hadoop-client/conf doesn't exist
```

重新安装。

```
Connection failed: [Errno 111] Connection refused to zwlbs6.com:2181
```

```
DELETE FROM hostcomponentstate WHERE service_name IN ('ZOOKEEPER');

DELETE FROM hostcomponentdesiredstate WHERE service_name IN ('ZOOKEEPER');

DELETE FROM servicecomponentdesiredstate WHERE service_name IN ('ZOOKEEPER');

DELETE FROM servicedesiredstate WHERE service_name IN ('ZOOKEEPER');

DELETE FROM clusterservices WHERE service_name IN ('ZOOKEEPER');
```

```
Connection failed to http://zwlbs6.com:50070 (<urlopen error [Errno 111] Connection refused>)
```

移除服务：

```Bash
curl -u admin:admin -H "X-Requested-By: ambari" -X DELETE http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/ZooKeeper

curl -u admin:admin -H "X-Requested-By: ambari" -X DELETE http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/ZooKeeper/MAPREDUCE2
```
Ambari does pretty good job on cleaning up the old installs. It's session specific and helps to clean the env.

example: python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py

```
python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py --silent --skip=users
```

```
Error: Could not find or load main class org.apache.hadoop.yarn.server.applicationhistoryservice.ApplicationHistoryServer
```

改变服务状态后再删除：

```
curl -i -H "X-Requested-By: ambari" -u admin:admin -X PUT -d '{"RequestInfo":{"context":"Stop Service"},"Body":{"ServiceInfo":{"state":"INSTALLED"}}}' http://192.168.24.226:8080/api/v1/clusters/zwlbs/services/ZOOKEEPER
```

```
resource_management.core.exceptions.Fail: Execution of 'conf-select set-conf-dir --package zookeeper --stack-version 2.4.3.0-227 --conf-version 0' returned 1. 2.4.3.0-227 Incorrect stack version
```

```
Traceback (most recent call last):
  File "/var/lib/ambari-agent/cache/stacks/HDP/2.0.6/hooks/before-ANY/scripts/hook.py", line 35, in <module>
    BeforeAnyHook().execute()
  File "/usr/lib/python2.6/site-packages/resource_management/libraries/script/script.py", line 219, in execute
    method(env)
  File "/var/lib/ambari-agent/cache/stacks/HDP/2.0.6/hooks/before-ANY/scripts/hook.py", line 26, in hook
    import params
  File "/var/lib/ambari-agent/cache/stacks/HDP/2.0.6/hooks/before-ANY/scripts/params.py", line 189, in <module>
    hadoop_conf_dir = conf_select.get_hadoop_conf_dir(force_latest_on_upgrade=True)
  File "/usr/lib/python2.6/site-packages/resource_management/libraries/functions/conf_select.py", line 401, in get_hadoop_conf_dir
    select(stack_name, "hadoop", version)
  File "/usr/lib/python2.6/site-packages/resource_management/libraries/functions/conf_select.py", line 266, in select
    shell.checked_call(get_cmd("set-conf-dir", package, version), logoutput=False, quiet=False, sudo=True)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 70, in inner
    result = function(command, **kwargs)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 92, in checked_call
    tries=tries, try_sleep=try_sleep)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 140, in _call_wrapper
    result = _call(command, **kwargs_copy)
  File "/usr/lib/python2.6/site-packages/resource_management/core/shell.py", line 291, in _call
    raise Fail(err_msg)
resource_management.core.exceptions.Fail: Execution of 'conf-select set-conf-dir --package hadoop --stack-version 2.4.3.0-227 --conf-version 0' returned 1. Traceback (most recent call last):
  File "/usr/bin/conf-select", line 178, in <module>
    setConfDir(options.pname, options.sver, options.cver)
  File "/usr/bin/conf-select", line 136, in setConfDir
    raise Exception("Expected confdir %s to be a symlink." % confdir)
Exception: Expected confdir /usr/hdp/2.4.3.0-227/hadoop/conf to be a symlink.
Error: Error: Unable to run the custom hook script ['/usr/bin/python', '/var/lib/ambari-agent/cache/stacks/HDP/2.0.6/hooks/before-ANY/scripts/hook.py', 'ANY', '/var/lib/ambari-agent/data/command-561.json', '/var/lib/ambari-agent/cache/stacks/HDP/2.0.6/hooks/before-ANY', '/var/lib/ambari-agent/data/structured-out-561.json', 'INFO', '/var/lib/ambari-agent/tmp']
```

```language
Could not determine HDP version for component zookeeper-server by calling '/usr/bin/hdp-select status zookeeper-server > /tmp/tmpE7_tnD'. Return Code: 1, Output: .
```
