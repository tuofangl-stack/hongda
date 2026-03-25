import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
    // ========== 前台页面 ==========
    {
        path:'/',
        redirect:'/index'
    },
    {
        path: '/index',
        name: 'index',
        component: () => import('../views/IndexView.vue')
    },
    {
        path: '/product',
        name: 'product',
        component: () => import('../views/ProductView.vue'),
    },
    {
        path: '/product/productId/:productId',
        name: 'productDetails',
        component: () => import("../views/ProductDetailsView.vue")
    },
    {
        path: '/example',
        name: 'example',
        component: () => import('../views/ExampleView.vue')
    },
    {
        path: '/news',
        name: 'news',
        component: () => import('../views/NewsView.vue')
    },
    {
        path: '/news/newsId/:newsId',
        name: 'newsDetails',
        component: () => import('../views/NewsDetailsView.vue')
    },
    {
        path: '/about',
        name: 'about',
        component: () => import('../views/AboutView.vue')
    },
    {
        path: '/login',
        name: 'UserLogin',
        component: () => import('../views/UserLogin.vue'),
        meta: { title: '登录/注册' }
    },

    // ========== 后台管理页面 ==========
    {
        path: '/admin/login',
        name: 'AdminLogin',
        component: () => import('../views/admin/Login.vue'),
        meta: { title: '管理员登录' }
    },
    {
        path: '/admin',
        component: () => import('../views/admin/AdminLayout.vue'),
        redirect: '/admin/dashboard',
        children: [
            {
                path: 'dashboard',
                name: 'AdminDashboard',
                component: () => import('../views/admin/Dashboard.vue'),
                meta: { title: '数据面板' }
            },
            {
                path: 'product',
                name: 'AdminProduct',
                component: () => import('../views/admin/Product.vue'),
                meta: { title: '产品管理' }
            },
            {
                path: 'product/add',
                name: 'AdminProductAdd',
                component: () => import('../views/admin/ProductForm.vue'),
                meta: { title: '新增产品' }
            },
            {
                path: 'product/edit/:id',
                name: 'AdminProductEdit',
                component: () => import('../views/admin/ProductForm.vue'),
                meta: { title: '编辑产品' }
            },
            {
                path: 'sale',
                name: 'AdminSale',
                component: () => import('../views/admin/Sale.vue'),
                meta: { title: '销售记录' }
            },
            {
                path: 'article',
                name: 'AdminArticle',
                component: () => import('../views/admin/ArticleManage.vue'),
                meta: { title: '文章管理' }
            },
            {
                path: 'slideshow',
                name: 'AdminSlideshow',
                component: () => import('../views/admin/SlideshowManage.vue'),
                meta: { title: '轮播图管理' }
            },
            {
                path: 'typeDetails',
                name: 'AdminTypeDetails',
                component: () => import('../views/admin/TypeDetailsManage.vue'),
                meta: { title: '前台产品管理' }
            }
        ]
    }
]

const router = new VueRouter({
    routes
})

// 后台路由守卫
router.beforeEach((to, from, next) => {
    if (to.path.startsWith('/admin') && to.path !== '/admin/login') {
        const token = localStorage.getItem('admin_token')
        if (!token) {
            next('/admin/login')
            return
        }
    }
    if (to.meta && to.meta.title) {
        document.title = to.meta.title + ' - 管理系统'
    }
    next()
})

export default router
