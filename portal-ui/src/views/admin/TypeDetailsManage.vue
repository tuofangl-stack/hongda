<template>
  <div>
    <div class="page-header">
      <h2>前台产品管理</h2>
      <el-button type="primary" icon="el-icon-plus" @click="showDialog()">新增产品</el-button>
    </div>
    <div class="page-card">
      <div class="filter-bar">
        <el-input v-model="filters.title" placeholder="搜索产品名称" clearable style="width:220px;" prefix-icon="el-icon-search" @clear="loadData" @keyup.enter.native="loadData" />
        <el-select v-model="filters.typeId" placeholder="产品分类" clearable style="width:160px;" @change="loadData">
          <el-option v-for="t in types" :key="t.typeId" :label="t.typeName" :value="t.typeId" />
        </el-select>
        <el-button type="primary" icon="el-icon-search" @click="loadData">搜索</el-button>
      </div>
      <el-table :data="list" v-loading="loading" stripe style="width:100%;">
        <el-table-column prop="typeDetaisId" label="ID" width="70" />
        <el-table-column label="图片" width="100">
          <template slot-scope="{row}">
            <el-image v-if="row.imageUrl1" :src="row.imageUrl1" style="width:70px;height:55px;border-radius:6px;" fit="cover" :preview-src-list="[row.imageUrl1]" />
            <span v-else style="color:#ccc;">无图</span>
          </template>
        </el-table-column>
        <el-table-column prop="title" label="产品名称" min-width="200" show-overflow-tooltip />
        <el-table-column label="分类" width="120">
          <template slot-scope="{row}">{{ getTypeName(row.typeId) }}</template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="170" />
        <el-table-column label="操作" width="160" fixed="right">
          <template slot-scope="{row}">
            <el-button type="text" @click="showDialog(row)">编辑</el-button>
            <el-button type="text" style="color:#f43f5e;" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination :current-page="pageNum" :page-size="pageSize" :total="total" layout="total, prev, pager, next" @current-change="p => { pageNum = p; loadData() }" />
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog :title="isEdit ? '编辑产品' : '新增产品'" :visible.sync="dialogVisible" width="700px" top="5vh">
      <el-form :model="form" :rules="rules" ref="detailForm" label-width="100px">
        <el-form-item label="产品名称" prop="title">
          <el-input v-model="form.title" placeholder="产品名称" />
        </el-form-item>
        <el-form-item label="产品分类" prop="typeId">
          <el-select v-model="form.typeId" placeholder="选择分类" style="width:100%;">
            <el-option v-for="t in types" :key="t.typeId" :label="t.typeName" :value="t.typeId" />
          </el-select>
        </el-form-item>
        <el-form-item label="主图(图片1)" prop="imageUrl1">
          <el-upload :action="uploadUrl" :headers="uploadHeaders" :show-file-list="false" :on-success="(res) => handleImgSuccess(res, 'imageUrl1')" accept="image/*">
            <el-image v-if="form.imageUrl1" :src="form.imageUrl1" style="width:200px;height:130px;border-radius:8px;" fit="cover" />
            <div v-else style="width:200px;height:130px;border:2px dashed #dcdfe6;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#909399;cursor:pointer;">
              <i class="el-icon-plus" style="font-size:24px;"></i>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item label="更多图片">
          <div style="display:flex;gap:12px;flex-wrap:wrap;">
            <div v-for="n in [2,3,4,5]" :key="n">
              <el-upload :action="uploadUrl" :headers="uploadHeaders" :show-file-list="false" :on-success="(res) => handleImgSuccess(res, 'imageUrl'+n)" accept="image/*">
                <el-image v-if="form['imageUrl'+n]" :src="form['imageUrl'+n]" style="width:120px;height:80px;border-radius:6px;" fit="cover" />
                <div v-else style="width:120px;height:80px;border:1px dashed #dcdfe6;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#c0c4cc;cursor:pointer;font-size:12px;">
                  图片{{n}}
                </div>
              </el-upload>
            </div>
          </div>
        </el-form-item>
        <el-form-item label="产品描述">
          <el-input v-model="form.introduction" type="textarea" :rows="4" placeholder="产品描述" />
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitting">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getTypeList, getTypeDetailsList, addTypeDetails, updateTypeDetails, deleteTypeDetails, uploadUrl, getUploadHeaders } from '@/api/adminApi'
export default {
  name: 'TypeDetailsManage',
  data() {
    return {
      list: [], types: [], loading: false, pageNum: 1, pageSize: 10, total: 0,
      filters: { title: '', typeId: null },
      dialogVisible: false, isEdit: false, submitting: false,
      uploadUrl, uploadHeaders: getUploadHeaders(),
      form: { typeDetaisId: null, title: '', typeId: null, imageUrl1: '', imageUrl2: '', imageUrl3: '', imageUrl4: '', imageUrl5: '', introduction: '' },
      rules: {
        title: [{ required: true, message: '请输入名称', trigger: 'blur' }],
        typeId: [{ required: true, message: '请选择分类', trigger: 'change' }]
      }
    }
  },
  mounted() { this.loadTypes(); this.loadData() },
  methods: {
    async loadTypes() {
      const res = await getTypeList(); this.types = res.data || []
    },
    async loadData() {
      this.loading = true
      try {
        const res = await getTypeDetailsList({ pageNum: this.pageNum, pageSize: this.pageSize, title: this.filters.title || undefined, typeId: this.filters.typeId || undefined })
        this.list = res.data.records || []; this.total = res.data.total || 0
      } finally { this.loading = false }
    },
    getTypeName(typeId) {
      const t = this.types.find(i => i.typeId === typeId)
      return t ? t.typeName : typeId
    },
    showDialog(row) {
      this.isEdit = !!row
      this.form = row ? { ...row } : { typeDetaisId: null, title: '', typeId: null, imageUrl1: '', imageUrl2: '', imageUrl3: '', imageUrl4: '', imageUrl5: '', introduction: '' }
      this.dialogVisible = true
      this.$nextTick(() => { if (this.$refs.detailForm) this.$refs.detailForm.clearValidate() })
    },
    handleImgSuccess(res, field) {
      if (res.code === 200) { this.form[field] = res.data; this.$message.success('上传成功') }
    },
    handleSubmit() {
      this.$refs.detailForm.validate(async valid => {
        if (!valid) return; this.submitting = true
        try {
          if (this.isEdit) { await updateTypeDetails(this.form); this.$message.success('修改成功') }
          else { await addTypeDetails(this.form); this.$message.success('新增成功') }
          this.dialogVisible = false; this.loadData()
        } finally { this.submitting = false }
      })
    },
    handleDelete(row) {
      this.$confirm(`确定删除「${row.title}」？`, '提示', { type: 'warning' }).then(async () => {
        await deleteTypeDetails(row.typeDetaisId); this.$message.success('删除成功'); this.loadData()
      }).catch(() => {})
    }
  }
}
</script>
