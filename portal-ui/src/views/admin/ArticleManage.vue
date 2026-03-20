<template>
  <div>
    <div class="page-header">
      <h2>文章管理</h2>
      <el-button type="primary" icon="el-icon-plus" @click="showDialog()">新增文章</el-button>
    </div>
    <div class="page-card">
      <div class="filter-bar">
        <el-input v-model="filters.title" placeholder="搜索标题" clearable style="width:220px;" prefix-icon="el-icon-search" @clear="loadData" @keyup.enter.native="loadData" />
        <el-button type="primary" icon="el-icon-search" @click="loadData">搜索</el-button>
      </div>
      <el-table :data="list" v-loading="loading" stripe style="width:100%;">
        <el-table-column prop="articleId" label="ID" width="70" />
        <el-table-column label="封面" width="100">
          <template slot-scope="{row}">
            <el-image v-if="row.cover" :src="row.cover" style="width:70px;height:50px;border-radius:6px;" fit="cover" />
            <span v-else style="color:#ccc;">无图</span>
          </template>
        </el-table-column>
        <el-table-column prop="title" label="标题" min-width="200" show-overflow-tooltip />
        <el-table-column prop="author" label="作者" width="100" />
        <el-table-column prop="createTime" label="发布时间" width="170" />
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
    <el-dialog :title="isEdit ? '编辑文章' : '新增文章'" :visible.sync="dialogVisible" width="700px" top="5vh">
      <el-form :model="form" :rules="rules" ref="articleForm" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="文章标题" />
        </el-form-item>
        <el-form-item label="作者">
          <el-input v-model="form.author" placeholder="文章作者" />
        </el-form-item>
        <el-form-item label="封面">
          <el-upload :action="uploadUrl" :headers="uploadHeaders" :show-file-list="false" :on-success="handleCoverSuccess" accept="image/*">
            <el-image v-if="form.cover" :src="form.cover" style="width:200px;height:120px;border-radius:8px;" fit="cover" />
            <div v-else style="width:200px;height:120px;border:2px dashed #dcdfe6;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#909399;cursor:pointer;">
              <i class="el-icon-plus" style="font-size:24px;"></i>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item label="简介">
          <el-input v-model="form.introduction" type="textarea" :rows="3" placeholder="文章简介" />
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="form.content" type="textarea" :rows="8" placeholder="文章内容（纯文本）" />
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
import { getArticleList, addArticle, updateArticle, deleteArticle, uploadUrl, getUploadHeaders } from '@/api/adminApi'
export default {
  name: 'ArticleManage',
  data() {
    return {
      list: [], loading: false, pageNum: 1, pageSize: 10, total: 0,
      filters: { title: '' },
      dialogVisible: false, isEdit: false, submitting: false,
      uploadUrl, uploadHeaders: getUploadHeaders(),
      form: { articleId: null, title: '', cover: '', introduction: '', content: '', contentHtml: '', author: '' },
      rules: { title: [{ required: true, message: '请输入标题', trigger: 'blur' }] }
    }
  },
  mounted() { this.loadData() },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const res = await getArticleList({ pageNum: this.pageNum, pageSize: this.pageSize, title: this.filters.title || undefined })
        this.list = res.data.records || []; this.total = res.data.total || 0
      } finally { this.loading = false }
    },
    showDialog(row) {
      this.isEdit = !!row
      this.form = row ? { ...row } : { articleId: null, title: '', cover: '', introduction: '', content: '', contentHtml: '', author: '' }
      this.dialogVisible = true
      this.$nextTick(() => { if (this.$refs.articleForm) this.$refs.articleForm.clearValidate() })
    },
    handleCoverSuccess(res) {
      if (res.code === 200) this.form.cover = res.data
    },
    handleSubmit() {
      this.$refs.articleForm.validate(async valid => {
        if (!valid) return; this.submitting = true
        try {
          if (this.isEdit) { await updateArticle(this.form); this.$message.success('修改成功') }
          else { await addArticle(this.form); this.$message.success('新增成功') }
          this.dialogVisible = false; this.loadData()
        } finally { this.submitting = false }
      })
    },
    handleDelete(row) {
      this.$confirm(`确定删除「${row.title}」？`, '提示', { type: 'warning' }).then(async () => {
        await deleteArticle(row.articleId); this.$message.success('删除成功'); this.loadData()
      }).catch(() => {})
    }
  }
}
</script>
