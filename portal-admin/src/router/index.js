import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/',
    component: () => import('../layout/AdminLayout.vue'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('../views/Dashboard.vue'),
        meta: { title: '数据面板' }
      },
      {
        path: 'product',
        name: 'Product',
        component: () => import('../views/Product.vue'),
        meta: { title: '产品管理' }
      },
      {
        path: 'product/add',
        name: 'ProductAdd',
        component: () => import('../views/ProductForm.vue'),
        meta: { title: '新增产品' }
      },
      {
        path: 'product/edit/:id',
        name: 'ProductEdit',
        component: () => import('../views/ProductForm.vue'),
        meta: { title: '编辑产品' }
      },
      {
        path: 'category',
        name: 'Category',
        component: () => import('../views/Category.vue'),
        meta: { title: '分类管理' }
      },
      {
        path: 'sale',
        name: 'Sale',
        component: () => import('../views/Sale.vue'),
        meta: { title: '销售记录' }
      }
    ]
  }
]

const router = new VueRouter({
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  document.title = (to.meta.title || '后台管理') + ' - 管理系统'
  const token = localStorage.getItem('admin_token')
  if (to.path !== '/login' && !token) {
    next('/login')
  } else {
    next()
  }
})

export default router
