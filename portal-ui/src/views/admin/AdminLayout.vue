<template>
  <div class="admin-layout">
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
          <el-menu-item index="/admin/dashboard">
            <i class="el-icon-data-analysis"></i>
            <span>数据面板</span>
          </el-menu-item>
          <el-submenu index="frontend-group">
            <template slot="title"><i class="el-icon-monitor"></i><span>前台内容</span></template>
            <el-menu-item index="/admin/slideshow">
              <i class="el-icon-picture-outline"></i><span>轮播图</span>
            </el-menu-item>
            <el-menu-item index="/admin/typeDetails">
              <i class="el-icon-box"></i><span>产品展示</span>
            </el-menu-item>
            <el-menu-item index="/admin/article">
              <i class="el-icon-document"></i><span>文章动态</span>
            </el-menu-item>
          </el-submenu>
          <el-menu-item index="/admin/product">
            <i class="el-icon-goods"></i>
            <span>商品管理</span>
          </el-menu-item>
          <el-menu-item index="/admin/sale">
            <i class="el-icon-shopping-cart-full"></i>
            <span>销售记录</span>
          </el-menu-item>
        </el-menu>
      </div>
    </aside>
    <div class="admin-main">
      <header class="admin-header">
        <div class="header-breadcrumb">{{ $route.meta.title || '后台管理' }}</div>
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
      if (path.startsWith('/admin/product')) return '/admin/product'
      if (path.startsWith('/admin/sale')) return '/admin/sale'
      if (path.startsWith('/admin/article')) return '/admin/article'
      if (path.startsWith('/admin/slideshow')) return '/admin/slideshow'
      if (path.startsWith('/admin/typeDetails')) return '/admin/typeDetails'
      return path
    },
    nickname() {
      return localStorage.getItem('admin_nickname') || '管理员'
    }
  },
  methods: {
    handleLogout() {
      this.$confirm('确定退出登录？', '提示', { type: 'warning' }).then(() => {
        localStorage.removeItem('admin_token')
        localStorage.removeItem('admin_nickname')
        this.$router.push('/admin/login')
      }).catch(() => {})
    }
  }
}
</script>
