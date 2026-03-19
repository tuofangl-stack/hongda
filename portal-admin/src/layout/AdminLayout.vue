<template>
  <div class="admin-layout">
    <!-- 侧边栏 -->
    <aside class="admin-sidebar">
      <div class="sidebar-logo">
        <i class="el-icon-s-platform" style="margin-right:8px;"></i>
        管理后台
      </div>
      <div class="sidebar-menu">
        <el-menu
          :default-active="activeMenu"
          :router="true"
          text-color="rgba(255,255,255,0.65)"
          active-text-color="#a78bfa"
        >
          <el-menu-item index="/dashboard">
            <i class="el-icon-data-analysis"></i>
            <span>数据面板</span>
          </el-menu-item>
          <el-menu-item index="/product">
            <i class="el-icon-goods"></i>
            <span>产品管理</span>
          </el-menu-item>
          <el-menu-item index="/sale">
            <i class="el-icon-shopping-cart-full"></i>
            <span>销售记录</span>
          </el-menu-item>
        </el-menu>
      </div>
    </aside>

    <!-- 主内容区 -->
    <div class="admin-main">
      <header class="admin-header">
        <div class="header-breadcrumb">
          {{ $route.meta.title || '后台管理' }}
        </div>
        <div class="header-right">
          <span style="color:#606266;font-size:14px;">{{ nickname }}</span>
          <el-button type="text" style="color:#f43f5e;" @click="handleLogout">
            <i class="el-icon-switch-button"></i> 退出
          </el-button>
        </div>
      </header>
      <main class="admin-content">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script>
export default {
  name: 'AdminLayout',
  computed: {
    activeMenu() {
      const path = this.$route.path
      if (path.startsWith('/product')) return '/product'
      if (path.startsWith('/sale')) return '/sale'
      return path
    },
    nickname() {
      return localStorage.getItem('admin_nickname') || '管理员'
    }
  },
  methods: {
    handleLogout() {
      this.$confirm('确定退出登录？', '提示', {
        type: 'warning'
      }).then(() => {
        localStorage.removeItem('admin_token')
        localStorage.removeItem('admin_nickname')
        this.$router.push('/login')
      }).catch(() => {})
    }
  }
}
</script>
