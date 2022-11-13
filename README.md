# SIT-board客户端

## 编译部署

得益于 Flutter 跨平台运行的优势，SIT-board 轻松实现了全平台运行，各个平台的编译流程细节可参考文档 [编译部署.md](docs/编译部署.md)。

## 使用说明

程序的具体使用说明可参考文档 [使用说明.md](docs/使用说明.md)

## 在线运行

[Live Demo](https://sit-board.github.io/

注意：受限于时间精力，故未针对Web端做平台相关的适配，部分功能在Web端无法使用。

Web端仅作为快速体验为目的，请以实际桌面端或移动端平台为准。

浏览器端右键或长按时可能会弹出剪切板权限提示，这是因为软件支持复制粘贴图形对象到本机剪切板。

## 模块划分

### 算法模块

算法模块主要实现了以下几个：

1. json_field_modifier
2. json_diff_patcher
3. json_model_undo_redo
4. json_model_sync

具体详细说明可参考文档 [核心算法实现.md](docs/核心算法实现.md)

### 本地存储模块

程序运行时数据的存储，参考文档 [本地存储模块.md](docs/本地存储模块.md)

### 白板模块

白板作为程序内部的一个独立模块，其视图模型和持久化拥有自己的数据结构，
参考文档 [白板数据的存储.md](docs/白板数据的存储结构.md)

白板实现了插件化方案, 参考文档 [白板元素插件系统.md](docs/白板元素插件系统.md)

### 分布式同步与通信模块

该程序基于MQTT分布式通信实现白板数据的同步，同步的方案构思可参考文档 [同步方案.md](docs/同步方案.md)