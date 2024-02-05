# opa-koans

![opa-koans](https://github.com/NewbMiao/opa-koans/workflows/opa-koans/badge.svg?branch=master)

OPA入门系列

OPA（OpenPolicyAgent）, 云原生时代的通用规则引擎，重新定义策略引擎，灵活而强大的声明式语言全面支持通用策略定义。

而且，2019年4月2号`OPA`正式进入了`CNCF`，作为孵化级托管项目，详见[声明](https://www.cncf.io/blog/2019/04/02/toc-votes-to-move-opa-into-cncf-incubator/)

## 什么是OPA

> see in [OPA philosophy docs](https://www.openpolicyagent.org/docs/latest/philosophy/#what-is-opa)

关键词：

- 轻量级的通用策略引擎
- 可与服务共存
- 集成方式可以是sidecar、主机级守护进程或库引入

![opa](/misc/opa-service.png)

文字太直白，看看OPA作者怎么说：

- [OPA: The Cloud Native Policy Engine - Torin Sandall, Styra](https://www.bilibili.com/video/BV1AE411V7Hs/)
- [Deep Dive- Open Policy Agent - Torin Sandall & Tim Hinrichs, Styra（2019)](https://www.bilibili.com/video/BV19E411A7BH/)

## 优点

- 强大的声明式策略
  - 上下文感知
  - 表达性强
  - 快速
  - 可移植

- 输入和输出支持任意格式

配合强大的声明式策略语言`Rego`，描述任意规则都不是问题

- 全面支持规则和系统解耦

![如图](/misc/decouple.png)

- 集承方式多
  - Daemon式服务
  - Go类库引入
- 决策快
  - [rule indexing](https://blog.openpolicyagent.org/optimizing-opa-rule-indexing-59f03f17caf3)
  
    ![决策树索引](/misc/rule-indexing.png)

  - [partial evaluation](https://blog.openpolicyagent.org/partial-evaluation-162750eaf422)
  
    ![将动态计算尽可能转为编译时确定的静态规则](/misc/partial-evaluation.png)

- 应用广泛

除了继承做auth外，还可以应用到`k8s`,`terraform`,`docker`,`kafka`,`sql`,`linux`上做规则决策

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

## 入门

### [一个RBAC例子](https://newbmiao.github.io/2020/03/13/opa-quick-start.html)

几行代码实现一个简单的RBAC认证服务: [example_rbac](https://github.com/NewbMiao/opa-koans/tree/master/quick-start)

```sh
cd quick-start
opa eval -i input.json -d data.json -d example.rego "data.example_rbac"
```

### [如何优雅的开发](https://newbmiao.github.io/2020/03/14/how-to-use-opa-cli-elegantly.html)

### 语法进阶

- [函数和虚拟文档要分清](https://newbmiao.github.io/2020/03/18/opa-func-and-virtual-doc.html)
- [简洁的推导式](https://newbmiao.github.io/2020/03/20/opa-comprehensions.html)
- [测试、性能分析和基准测试](https://newbmiao.github.io/2020/04/05/opa-test-profile-and-benchmark.html)
- [分布式利器Bundle](https://newbmiao.github.io/2020/04/16/opa-bundle.html)
  - [Bundle demo doc](https://newbmiao.github.io/opa-koans/bundle/)

## 实战

[可扩展的Entitlements api demo](/demos/): 可扩展的rules data + entitlemnts policy


文档一点点完善中。。。
