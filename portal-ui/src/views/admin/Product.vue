<template>
  <div>
    <div class="page-header">
      <h2>产品管理</h2>
      <el-button type="primary" icon="el-icon-plus" @click="$router.push('/admin/product/add')">新增产品</el-button>
    </div>
    <div class="page-card">
      <div class="filter-bar">
        <el-input v-model="filters.name" placeholder="搜索产品名称" clearable style="width:220px;" prefix-icon="el-icon-search" @clear="loadData" @keyup.enter.native="loadData" />
        <el-select v-model="filters.status" placeholder="上架状态" clearable style="width:140px;" @change="loadData">
          <el-option label="上架" :value="1" />
          <el-option label="下架" :value="0" />
        </el-select>
        <el-button type="primary" icon="el-icon-search" @click="loadData">搜索</el-button>
      </div>
      <el-table :data="list" v-loading="loading" stripe style="width:100%;">
        <el-table-column prop="productId" label="ID" width="70" />
        <el-table-column label="封面" width="90">
          <template slot-scope="{row}">
            <el-image v-if="row.cover" :src="row.cover" style="width:60px;height:60px;border-radius:8px;" fit="cover" :preview-src-list="[row.cover]" />
            <span v-else style="color:#ccc;">无图</span>
          </template>
        </el-table-column>
        <el-table-column prop="name" label="产品名称" min-width="180" show-overflow-tooltip />
        <el-table-column prop="price" label="价格(元)" width="130">
          <template slot-scope="{row}"><span style="color:#f59e0b;font-weight:600;">¥{{ Number(row.price).toLocaleString() }}</span></template>
        </el-table-column>
        <el-table-column prop="stock" label="库存" width="80" />
        <el-table-column prop="sales" label="销量" width="80" />
        <el-table-column prop="views" label="浏览量" width="90" />
        <el-table-column label="状态" width="90">
          <template slot-scope="{row}"><span :class="row.status===1?'status-on':'status-off'">{{ row.status===1?'上架':'下架' }}</span></template>
        </el-table-column>
        <el-table-column label="操作" width="160" fixed="right">
          <template slot-scope="{row}">
            <el-button type="text" @click="$router.push('/admin/product/edit/'+row.productId)">编辑</el-button>
            <el-button type="text" style="color:#f43f5e;" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination :current-page="pageNum" :page-size="pageSize" :total="total" layout="total, prev, pager, next" @current-change="handlePageChange" />
    </div>
  </div>
</template>

<script>
import { getProductList, deleteProduct } from '@/api/adminApi'
export default {
  name: 'AdminProduct',
  data() {
    return { list: [], loading: false, pageNum: 1, pageSize: 10, total: 0, filters: { name: '', status: null } }
  },
  mounted() { this.loadData() },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const res = await getProductList({ pageNum: this.pageNum, pageSize: this.pageSize, name: this.filters.name || undefined, status: this.filters.status !== null ? this.filters.status : undefined })
        this.list = res.data.records || []; this.total = res.data.total || 0
      } finally { this.loading = false }
    },
    handlePageChange(page) { this.pageNum = page; this.loadData() },
    handleDelete(row) {
      this.$confirm(`确定删除产品「${row.name}」？`, '提示', { type: 'warning' }).then(async () => {
        await deleteProduct(row.productId); this.$message.success('删除成功'); this.loadData()
      }).catch(() => {})
    }
  }
}
</script>
