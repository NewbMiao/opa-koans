# opa-koans

OPA入门系列

OPA，重新定义规则引擎，灵活而强大的声明式语言全面支持通用策略定义。

## 为什么做这个教程

- 国外项目接触比较多
- 底层是Go实现，简洁而优雅
- 希望给国内规则引擎多一种了解，多一个选择。

## 什么是OPA

> see in [OPA philosophy docs](https://www.openpolicyagent.org/docs/latest/philosophy/#what-is-opa)

关键词：

- 轻量级的通用策略引擎
- 可与服务共存
- 集成方式可以是sidecar、主机级守护进程或库引入

![opa](https://d33wubrfki0l68.cloudfront.net/b394f524e15a67457b85fdfeed02ff3f2764eb9e/6ac2b/docs/latest/images/opa-service.svg)

文字太直白，看看OPA作者怎么说：
[OPA: The Cloud Native Policy Engine - Torin Sandall, Styra](https://www.youtube.com/watch?v=XEHeexPpgrA&feature=youtu.be)

## 优点

- 强大的声明式策略
  - 上下文感知
  - 表达性强
  - 快速
  - 可移植

- 输入和输出支持任意格式

配合强大的声明式策略语言Rego，描述任意规则都不是问题

- 全面支持规则和系统解耦

![如图](https://d33wubrfki0l68.cloudfront.net/7929e52d7c6324994d75e05d7e132d84e2308475/00249/docs/latest/images/benefits.svg)

- 集承方式多
  - Daemon式服务
  - Go类库引入
- 决策快
  - [rule indexing](https://blog.openpolicyagent.org/optimizing-opa-rule-indexing-59f03f17caf3)
  - [partial evaluatio](https://blog.openpolicyagent.org/partial-evaluation-162750eaf422)
- 应用广泛

除了继承做auth外，还可以应用到k8s,terraform,docker,kafka,sql,linux上做规则决策

- 工具齐全
  - 有命令行，有交互式运行环境
  - 支持测试，性能分析（底层实现Go）
  - 有强大的交互式编辑器扩展[vscode-opa](https://marketplace.visualstudio.com/items?itemName=tsandall.opa)
  - 有[playground](https://play.openpolicyagent.org/)分享代码

## 安装

为了性能，推荐使用最新 [OPA latest release](https://github.com/open-policy-agent/opa/releases/latest)

```shell
# mac
curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_darwin_amd64
chmod +x opa
mv opa /usr/local/bin/opa

# or use brew（not latest version）
brew install opa
```

## 目录

### [一个RBAC例子](http://blog.newbmiao.com/2020/03/13/opa-quick-start.html)

几行代码实现一个简单的RBAC认证服务: [example_rbac](/quick-start)

```sh
cd quick-start
opa eval -i input.json -d data.json -d example.rego "data.example_rbac"
```

### [如何优雅的开发](http://blog.newbmiao.com/2020/03/14/how-to-use-opa-cli-elegantly.html)

### 语法进阶

### bundle封装

### 实战

文档一点点完善中。。。
