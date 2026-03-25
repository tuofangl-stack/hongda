import axios from 'axios'
import { Message } from 'element-ui'
import router from '../router'

const api = axios.create({
  baseURL: '',
  timeout: 15000,
})

// 请求拦截器 - 自动附带Token
api.interceptors.request.use(config => {
  const token = localStorage.getItem('admin_token')
  if (token) {
    config.headers['Authorization'] = 'Bearer ' + token
  }
  return config
})

// 响应拦截器
api.interceptors.response.use(
  response => {
    const res = response.data
    if (res.code !== 200) {
      Message.error(res.message || '请求失败')
      return Promise.reject(res)
    }
    return res
  },
  error => {
    if (error.response && error.response.status === 401) {
      Message.error('登录已过期，请重新登录')
      localStorage.removeItem('admin_token')
      router.push('/login')
    } else {
      Message.error(error.message || '网络错误')
    }
    return Promise.reject(error)
  }
)

// ========== 登录 ==========
export function login(data) {
  return api.post('/admin/login', data)
}

export function getUserInfo() {
  return api.get('/admin/userInfo')
}

// ========== 产品 ==========
export function getProductList(params) {
  return api.get('/admin/product/list', { params })
}

export function getProduct(id) {
  return api.get('/admin/product/' + id)
}

export function addProduct(data) {
  return api.post('/admin/product', data)
}

export function updateProduct(data) {
  return api.put('/admin/product', data)
}

export function deleteProduct(id) {
  return api.delete('/admin/product/' + id)
}

export function getAllProducts() {
  return api.get('/admin/product/all')
}

// ========== Dashboard ==========
export function getDashboardStats() {
  return api.get('/admin/dashboard/stats')
}

export function getDashboardTrend(days) {
  return api.get('/admin/dashboard/trend', { params: { days } })
}

export function getTopProducts() {
  return api.get('/admin/dashboard/topProducts')
}

// ========== 销售记录 ==========
export function getSaleList(params) {
  return api.get('/admin/sale/list', { params })
}

export function addSale(data) {
  return api.post('/admin/sale', data)
}

export function deleteSale(id) {
  return api.delete('/admin/sale/' + id)
}

// ========== 分类管理 ==========
export function getCategoryList() {
  return api.get('/admin/category/list')
}

export function addCategory(data) {
  return api.post('/admin/category', data)
}

export function updateCategory(data) {
  return api.put('/admin/category', data)
}

export function deleteCategory(id) {
  return api.delete('/admin/category/' + id)
}

// ========== 上传 ==========
export const uploadUrl = '/admin/upload'

export function getUploadHeaders() {
  return {
    Authorization: 'Bearer ' + localStorage.getItem('admin_token')
  }
}

// ========== 用户管理 ==========
export function getUserList(params) {
  return api.get('/admin/user/list', { params })
}

export function updateUserStatus(data) {
  return api.put('/admin/user/status', data)
}

export function deleteUser(id) {
  return api.delete('/admin/user/' + id)
}

export default api
