# 后台管理系统实施方案

为现有企业门户网站新增后台管理系统，包含登录、产品管理（图片/描述/价格）、销售与浏览量统计面板。

## User Review Required

> [!IMPORTANT]
> **前端方案选择**：计划创建独立的 `portal-admin` Vue 2 项目, 使用 Element UI 组件库做管理后台 UI。运行在 `8086` 端口，与现有前端 (`8087`) 分离。
>
> **认证方式**：使用 JWT Token 做后台登录认证，简单轻量不需要引入 Spring Security。
>
> **产品 vs 现有 TypeDetails**：现有的 `t_type_details` 表没有价格和销量字段。计划新建一张独立的 `t_product` 表，字段更完整（价格、库存、销量、浏览量、多图片），不影响现有前端。

---

## Proposed Changes

### 数据库层

新增 4 张表，整理为 `portal_admin.sql` 文件。

#### [NEW] [portal_admin.sql](file:///d:/Project/hongda/portal_admin.sql)

```sql
-- 1. 管理员用户表
t_admin_user (
  admin_id BIGINT PK AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE NOT NULL,  -- 用户名
  password VARCHAR(255) NOT NULL,         -- MD5 加密密码
  nickname VARCHAR(50),                   -- 昵称
  avatar   VARCHAR(255),                  -- 头像
  create_time DATETIME,
  is_delete INT DEFAULT 0
)

-- 2. 产品表（含图片/描述/价格）
t_product (
  product_id BIGINT PK AUTO_INCREMENT,
  name VARCHAR(255),          -- 产品名称
  type_id INT,                -- 关联分类
  cover VARCHAR(255),         -- 封面图
  images TEXT,                -- 多图(JSON数组)
  description TEXT,           -- 产品描述
  price DECIMAL(10,2),        -- 价格
  stock INT DEFAULT 0,        -- 库存
  sales INT DEFAULT 0,        -- 销量
  views INT DEFAULT 0,        -- 浏览量
  status INT DEFAULT 1,       -- 1上架 0下架
  create_time DATETIME,
  update_time DATETIME,
  is_delete INT DEFAULT 0
)

-- 3. 浏览记录表
t_page_view (
  view_id BIGINT PK AUTO_INCREMENT,
  page_type VARCHAR(50),      -- 页面类型: index/product/news/about
  ref_id BIGINT,              -- 关联的资源id(可空)
  ip VARCHAR(50),
  create_time DATETIME
)

-- 4. 销售记录表
t_sale_record (
  record_id BIGINT PK AUTO_INCREMENT,
  product_id BIGINT,
  quantity INT DEFAULT 1,
  amount DECIMAL(10,2),
  buyer VARCHAR(100),         -- 买家信息
  remark VARCHAR(255),
  create_time DATETIME,
  is_delete INT DEFAULT 0
)
```

同时插入一条默认管理员：`admin / admin123`

---

### 后端 - 认证模块

#### [MODIFY] [pom.xml](file:///d:/Project/hongda/portal-server/pom.xml)
- 新增 `jjwt` 依赖 (0.9.1) 用于 JWT Token
- 新增 `commons-codec` 用于密码加密

#### [NEW] [JwtUtils.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/utils/JwtUtils.java)
- JWT Token 生成与解析工具类

#### [NEW] [AdminLoginInterceptor.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/config/AdminLoginInterceptor.java)
- 拦截 `/admin/**` 请求，验证 JWT Token
- 排除 `/admin/login` 登录接口

#### [MODIFY] [WebMvcConfig.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/config/WebMvcConfig.java)
- 注册 AdminLoginInterceptor 拦截器
- 添加 CORS 跨域配置（admin 前端 8086 → 后端 8888）

#### [NEW] [AdminUser.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/entity/AdminUser.java)
#### [NEW] [AdminUserMapper.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/mapper/AdminUserMapper.java)
#### [NEW] [AdminUserService.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/service/AdminUserService.java)
#### [NEW] [AdminUserServiceImpl.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/service/impl/AdminUserServiceImpl.java)
#### [NEW] [AdminLoginController.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/controller/AdminLoginController.java)
- `POST /admin/login` — 登录，返回 JWT Token
- `GET /admin/userInfo` — 获取当前用户信息

---

### 后端 - 产品模块

#### [NEW] [Product.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/entity/Product.java)
#### [NEW] [ProductMapper.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/mapper/ProductMapper.java)
#### [NEW] [ProductService.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/service/ProductService.java)
#### [NEW] [ProductServiceImpl.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/service/impl/ProductServiceImpl.java)
#### [NEW] [AdminProductController.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/controller/AdminProductController.java)
- `GET /admin/product/list` — 分页查询产品
- `GET /admin/product/{id}` — 产品详情
- `POST /admin/product` — 新增产品
- `PUT /admin/product` — 编辑产品
- `DELETE /admin/product/{id}` — 删除产品

---

### 后端 - 统计与上传

#### [NEW] [PageView.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/entity/PageView.java)
#### [NEW] [SaleRecord.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/entity/SaleRecord.java)
#### 对应 Mapper / Service / ServiceImpl (各 2 套)

#### [NEW] [AdminDashboardController.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/controller/AdminDashboardController.java)
- `GET /admin/dashboard/stats` — 总览统计（总销量、总销售额、总浏览量、产品数等）
- `GET /admin/dashboard/trend` — 近7天/30天趋势数据
- `GET /admin/dashboard/topProducts` — 销量Top产品排行

#### [NEW] [AdminSaleController.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/controller/AdminSaleController.java)
- `GET /admin/sale/list` — 销售记录列表
- `POST /admin/sale` — 新增销售记录

#### [NEW] [FileUploadController.java](file:///d:/Project/hongda/portal-server/src/main/java/com/record/controller/FileUploadController.java)
- `POST /admin/upload` — 上传图片，保存到 `static/uploads/` 目录

---

### 前端 - 管理后台 (`portal-admin`)

#### [NEW] portal-admin 项目
在 `d:\Project\hongda\portal-admin\` 创建新的 Vue 2 + Element UI 项目

**技术栈**：Vue 2 + Vue Router + Axios + Element UI + ECharts

**页面规划**：

| 路由 | 页面 | 功能 |
|------|------|------|
| `/login` | 登录页 | 深色渐变背景 + 玻璃拟态登录卡片 |
| `/` | Dashboard | 统计卡片 + ECharts 趋势图 + 热销排行 |
| `/product` | 产品管理 | 表格列表 + 搜索/筛选/分页 |
| `/product/add` | 新增产品 | 表单: 名称/分类/图片上传/描述/价格/库存 |
| `/product/edit/:id` | 编辑产品 | 同上，回填数据 |
| `/sale` | 销售记录 | 表格列表 + 新增记录弹窗 |
| `/article` | 文章管理 | 复用现有 Article 接口做 CRUD |
| `/slideshow` | 轮播图管理 | 复用现有 Slideshow 接口做 CRUD |

**UI 风格**：
- 深色侧边栏 + 浅色内容区
- 统计卡片使用渐变色背景 + 图标
- 表格使用 Element UI 组件，带筛选和分页
- ECharts 图表展示趋势数据
- 登录页使用玻璃拟态效果

---

## Verification Plan

### 浏览器测试
1. 启动后端 `portal-server` (port 8888)
2. 启动管理前端 `portal-admin` (port 8086)
3. 通过浏览器访问 `http://localhost:8086`
4. 测试登录 → Dashboard 展示 → 产品 CRUD 操作

### 手动验证步骤
1. **登录测试**：使用 `admin / admin123` 登录，验证 JWT Token 返回
2. **产品新增**：点击"新增产品"，填写表单（名称、价格、描述、上传图片），保存后列表刷新验证
3. **产品编辑/删除**：编辑修改价格、删除产品验证
4. **Dashboard**：查看统计卡片数据是否正确展示，图表是否渲染
5. **销售记录**：新增一条销售记录，验证 Dashboard 数据更新
