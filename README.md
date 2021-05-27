# Cloud Native Application With Spring Cloud Kubernetes
This is a demo project for building a cloud native application with [Spring Cloud Kubernetes](https://spring.io/projects/spring-cloud-kubernetes). 
I do not develop this project from scratch.This project is a variant of [RuoYi-Cloud](http://doc.ruoyi.vip/ruoyi-cloud/).

## Technology selection

- Java 8
- Spring Boot 2.3.3.RELEASE
- Spring Cloud Hoxton.SR8
    - Spring Cloud Kubernetes
    - Spring Cloud OpenFeign
    - Spring Cloud LoadBalancer
    - Spring Cloud Gateway
    - Spring Cloud Sleuth
- mybatis-plus 3.4.0
- swagger 3.0.0

## How to use

### configure kubernetes

Spring Cloud Kubernetes use [Fabric8 Kubernetes Java Client](https://github.com/fabric8io/kubernetes-client) to call Kubernetes API.
So you can use settings from different sources. 
For example, I copy my Kubernetes Cluster's Kube config file to `.kube` directory which is under os user root directory

### configure dev environment

Create a kubernetes namespace named `wm-test` which is defined in `bootstrap.yml`.
Then you can create a Kubernetes ConfigMap to externalize the parameters to pass to cn4j like `application-{profile}.yaml`.
```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: gateway-dev
  namespace: wm-test
data:
  application.yml: |-
    backend-service-alias: ''
    spring:
      profiles: dev
      cloud:
        kubernetes:
          discovery:
            enabled: false 
        gateway: 
          routes:
            # 认证中心
            - id: auth
              uri: http://localhost:7000
              predicates:
                - Path=/auth/**
              filters:
                - StripPrefix=1
            # 系统服务
            - id: system
              uri: http://localhost:8001
              predicates:
                - Path=/system/**
              filters:
                - StripPrefix=1
      redis:
        host: #YOUR-REDIS-ADDRESS
        database: 0

```
```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: auth-dev
  namespace: wm-test
data:
  application.yml: |-
    local:
      feign:
        server:
          system:
            url: http://localhost:8001
    spring:
      profiles: dev
      redis:
        host: #YOUR-REDIS-ADDRESS
        database: 0

```
```yaml
kind: ConfigMap
apiVersion: v1
metadata:
  name: system-dev
  namespace: wm-test
data:
  application.yml: |-
    spring:
      profiles: dev
    springfox:
      documentation:
        swagger-ui:
          enabled: true

```
active spring profile to dev

### paging

`GET http://localhost:8001/dict/type/list?pageNum=1&pageSize=10&orderByColumn[]=dictName,dictType&orderDesc[]=true,false`  
> orderByColumn and orderDesc need one-to-one correspondence
## License

MIT
