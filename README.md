# Nginx-QUIC-php
开启Nginx支持HTTP3.0/QUIC测试，搭配php8.0版本

## 使用
```yaml
# 构造镜像，默认CentOS 8系统（搭配的php8）
docker build -t nginx-quic-php80 .

# 构造镜像，需要CentOS 7系统使用此命令（搭配的php74）
docker build -f ./centos7/Dockerfile -t nginx-quic-php74 .

# 启动容器
docker run -it --name nginx-quic-php80 -d nginx-quic-php80

# 针对php版本其他，使用remi源可自由切换，可多版本共存方便测试

# 证书和域名记得自行更换
```
### 官网文档
- [https://hg.nginx.org/nginx-quic](https://hg.nginx.org/nginx-quic)
- [https://github.com/google/boringssl](https://github.com/google/boringssl)
- [https://rpms.remirepo.net/](https://rpms.remirepo.net/)
- [https://copr.fedorainfracloud.org/coprs/ryoh/nginx-quic/](https://copr.fedorainfracloud.org/coprs/ryoh/nginx-quic/)

### 验证HTTP3是否生效
- google浏览器F12查看网络的请求协议：h3-29标识
- 火狐目前需要手工开启（地址栏中输入about:config,然后搜索http3，将network.http.http3.enabled设置为true，重启浏览器）
- [https://http3check.net/](https://http3check.net/) 在线验证站点是否启用HTTP3

### HTTP3站点应用
[https://translate.google.cn/](https://translate.google.cn/) 目前google翻译上可查看已使用HTTP3