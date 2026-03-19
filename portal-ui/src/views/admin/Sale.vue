<template>
  <div>
    <div class="page-header">
      <h2>销售记录</h2>
      <el-button type="primary" icon="el-icon-plus" @click="dialogVisible = true">新增销售记录</el-button>
    </div>
    <div class="page-card">
      <el-table :data="list" v-loading="loading" stripe style="width:100%;">
        <el-table-column prop="recordId" label="ID" width="70" />
        <el-table-column prop="productId" label="产品ID" width="90" />
        <el-table-column prop="buyer" label="买家" min-width="120" show-overflow-tooltip />
        <el-table-column prop="quantity" label="数量" width="80" />
        <el-table-column label="金额(元)" width="140">
          <template slot-scope="{row}"><span style="color:#f59e0b;font-weight:600;">¥{{ Number(row.amount).toLocaleString() }}</span></template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" min-width="180" show-overflow-tooltip />
        <el-table-column prop="createTime" label="时间" width="170" />
        <el-table-column label="操作" width="100" fixed="right">
          <template slot-scope="{row}"><el-button type="text" style="color:#f43f5e;" @click="handleDelete(row)">删除</el-button></template>
        </el-table-column>
      </el-table>
      <el-pagination :current-page="pageNum" :page-size="pageSize" :total="total" layout="total, prev, pager, next" @current-change="handlePageChange" />
    </div>

    <el-dialog title="新增销售记录" :visible.sync="dialogVisible" width="500px">
      <el-form :model="form" :rules="rules" ref="saleForm" label-width="90px">
        <el-form-item label="产品" prop="productId">
          <el-select v-model="form.productId" placeholder="选择产品" style="width:100%;" filterable @change="handleProductChange">
            <el-option v-for="p in products" :key="p.productId" :label="p.name" :value="p.productId" />
          </el-select>
        </el-form-item>
        <el-form-item label="数量" prop="quantity"><el-input-number v-model="form.quantity" :min="1" style="width:100%;" /></el-form-item>
        <el-form-item label="金额" prop="amount"><el-input-number v-model="form.amount" :min="0" :precision="2" style="width:100%;" /></el-form-item>
        <el-form-item label="买家"><el-input v-model="form.buyer" placeholder="买家信息" /></el-form-item>
        <el-form-item label="备注"><el-input v-model="form.remark" type="textarea" placeholder="备注" /></el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleAdd" :loading="submitting">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getSaleList, addSale, deleteSale, getAllProducts } from '@/api/adminApi'
export default {
  name: 'AdminSale',
  data() {
    return {
      list: [], loading: false, pageNum: 1, pageSize: 10, total: 0,
      dialogVisible: false, submitting: false, products: [],
      form: { productId: null, quantity: 1, amount: 0, buyer: '', remark: '' },
      rules: { productId: [{ required: true, message: '请选择产品', trigger: 'change' }], quantity: [{ required: true }], amount: [{ required: true }] }
    }
  },
  mounted() { this.loadData(); this.loadProducts() },
  methods: {
    async loadData() {
      this.loading = true
      try { const res = await getSaleList({ pageNum: this.pageNum, pageSize: this.pageSize }); this.list = res.data.records || []; this.total = res.data.total || 0 } finally { this.loading = false }
    },
    async loadProducts() { const res = await getAllProducts(); this.products = res.data || [] },
    handlePageChange(page) { this.pageNum = page; this.loadData() },
    handleProductChange(pid) { const p = this.products.find(i => i.productId === pid); if (p) this.form.amount = Number(p.price) * this.form.quantity },
    handleAdd() {
      this.$refs.saleForm.validate(async valid => {
        if (!valid) return; this.submitting = true
        try { await addSale(this.form); this.$message.success('新增成功'); this.dialogVisible = false; this.form = { productId: null, quantity: 1, amount: 0, buyer: '', remark: '' }; this.loadData() } finally { this.submitting = false }
      })
    },
    handleDelete(row) {
      this.$confirm('确定删除此销售记录？', '提示', { type: 'warning' }).then(async () => { await deleteSale(row.recordId); this.$message.success('删除成功'); this.loadData() }).catch(() => {})
    }
  }
}
</script>
