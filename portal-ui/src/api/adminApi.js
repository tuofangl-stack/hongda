import axios from 'axios'
import { Message } from 'element-ui'
import router from '../router'

const adminApi = axios.create({
  baseURL: '',
  timeout: 15000,
})

// 请求拦截器 - 自动附带Token
adminApi.interceptors.request.use(config => {
  const token = localStorage.getItem('admin_token')
  if (token) {
    config.headers['Authorization'] = 'Bearer ' + token
  }
  return config
})

// 响应拦截器
adminApi.interceptors.response.use(
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
      router.push('/admin/login')
    } else {
      Message.error(error.message || '网络错误')
    }
    return Promise.reject(error)
  }
)

// ========== 登录 ==========
export function login(data) {
  return adminApi.post('/admin/login', data)
}

export function getUserInfo() {
  return adminApi.get('/admin/userInfo')
}

// ========== 产品 ==========
export function getProductList(params) {
  return adminApi.get('/admin/product/list', { params })
}

export function getProduct(id) {
  return adminApi.get('/admin/product/' + id)
}

export function addProduct(data) {
  return adminApi.post('/admin/product', data)
}

export function updateProduct(data) {
  return adminApi.put('/admin/product', data)
}

export function deleteProduct(id) {
  return adminApi.delete('/admin/product/' + id)
}

export function getAllProducts() {
  return adminApi.get('/admin/product/all')
}

// ========== Dashboard ==========
export function getDashboardStats() {
  return adminApi.get('/admin/dashboard/stats')
}

export function getDashboardTrend(days) {
  return adminApi.get('/admin/dashboard/trend', { params: { days } })
}

export function getTopProducts() {
  return adminApi.get('/admin/dashboard/topProducts')
}

// ========== 销售记录 ==========
export function getSaleList(params) {
  return adminApi.get('/admin/sale/list', { params })
}

export function addSale(data) {
  return adminApi.post('/admin/sale', data)
}

export function deleteSale(id) {
  return adminApi.delete('/admin/sale/' + id)
}

// ========== 上传 ==========
export const uploadUrl = '/admin/upload'

export function getUploadHeaders() {
  return {
    Authorization: 'Bearer ' + localStorage.getItem('admin_token')
  }
}

// ========== 文章管理 ==========
export function getArticleList(params) {
  return adminApi.get('/admin/article/list', { params })
}

export function getArticle(id) {
  return adminApi.get('/admin/article/' + id)
}

export function addArticle(data) {
  return adminApi.post('/admin/article', data)
}

export function updateArticle(data) {
  return adminApi.put('/admin/article', data)
}

export function deleteArticle(id) {
  return adminApi.delete('/admin/article/' + id)
}

// ========== 轮播图管理 ==========
export function getSlideshowList() {
  return adminApi.get('/admin/slideshow/list')
}

export function addSlideshow(data) {
  return adminApi.post('/admin/slideshow', data)
}

export function updateSlideshow(data) {
  return adminApi.put('/admin/slideshow', data)
}

export function deleteSlideshow(id) {
  return adminApi.delete('/admin/slideshow/' + id)
}

// ========== 前台产品管理(TypeDetails) ==========
export function getTypeList() {
  return adminApi.get('/admin/typeDetails/types')
}

export function addType(data) {
  return adminApi.post('/admin/typeDetails/type', data)
}

export function deleteType(id) {
  return adminApi.delete('/admin/typeDetails/type/' + id)
}

export function getTypeDetailsList(params) {
  return adminApi.get('/admin/typeDetails/list', { params })
}

export function getTypeDetails(id) {
  return adminApi.get('/admin/typeDetails/' + id)
}

export function addTypeDetails(data) {
  return adminApi.post('/admin/typeDetails', data)
}

export function updateTypeDetails(data) {
  return adminApi.put('/admin/typeDetails', data)
}

export function deleteTypeDetails(id) {
  return adminApi.delete('/admin/typeDetails/' + id)
}

export default adminApi

