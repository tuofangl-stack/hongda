<template>
  <div>
    <div class="page-header">
      <h2>轮播图管理</h2>
      <el-button type="primary" icon="el-icon-plus" @click="showDialog()">新增轮播图</el-button>
    </div>
    <div class="page-card">
      <el-table :data="list" v-loading="loading" stripe style="width:100%;">
        <el-table-column prop="slideshowId" label="ID" width="70" />
        <el-table-column label="图片" min-width="300">
          <template slot-scope="{row}">
            <el-image v-if="row.imageUrl" :src="row.imageUrl" style="width:260px;height:100px;border-radius:8px;" fit="cover" :preview-src-list="[row.imageUrl]" />
            <span v-else style="color:#ccc;">无图</span>
          </template>
        </el-table-column>
        <el-table-column prop="introduction" label="描述" min-width="200" show-overflow-tooltip />
        <el-table-column prop="createTime" label="创建时间" width="170" />
        <el-table-column label="操作" width="160" fixed="right">
          <template slot-scope="{row}">
            <el-button type="text" @click="showDialog(row)">编辑</el-button>
            <el-button type="text" style="color:#f43f5e;" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <el-dialog :title="isEdit ? '编辑轮播图' : '新增轮播图'" :visible.sync="dialogVisible" width="600px">
      <el-form :model="form" :rules="rules" ref="slideshowForm" label-width="80px">
        <el-form-item label="图片" prop="imageUrl">
          <el-upload :action="uploadUrl" :headers="uploadHeaders" :show-file-list="false" :on-success="handleSuccess" accept="image/*">
            <el-image v-if="form.imageUrl" :src="form.imageUrl" style="width:100%;max-height:200px;border-radius:8px;" fit="cover" />
            <div v-else style="width:100%;height:150px;border:2px dashed #dcdfe6;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#909399;cursor:pointer;">
              <div style="text-align:center;"><i class="el-icon-plus" style="font-size:28px;"></i><div style="margin-top:4px;">点击上传</div></div>
            </div>
          </el-upload>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.introduction" type="textarea" :rows="3" placeholder="轮播图描述（可选）" />
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
import { getSlideshowList, addSlideshow, updateSlideshow, deleteSlideshow, uploadUrl, getUploadHeaders } from '@/api/adminApi'
export default {
  name: 'SlideshowManage',
  data() {
    return {
      list: [], loading: false,
      dialogVisible: false, isEdit: false, submitting: false,
      uploadUrl, uploadHeaders: getUploadHeaders(),
      form: { slideshowId: null, imageUrl: '', introduction: '' },
      rules: { imageUrl: [{ required: true, message: '请上传图片', trigger: 'change' }] }
    }
  },
  mounted() { this.loadData() },
  methods: {
    async loadData() {
      this.loading = true
      try { const res = await getSlideshowList(); this.list = res.data || [] } finally { this.loading = false }
    },
    showDialog(row) {
      this.isEdit = !!row
      this.form = row ? { ...row } : { slideshowId: null, imageUrl: '', introduction: '' }
      this.dialogVisible = true
    },
    handleSuccess(res) {
      if (res.code === 200) { this.form.imageUrl = res.data; this.$message.success('上传成功') }
    },
    handleSubmit() {
      this.$refs.slideshowForm.validate(async valid => {
        if (!valid) return; this.submitting = true
        try {
          if (this.isEdit) { await updateSlideshow(this.form); this.$message.success('修改成功') }
          else { await addSlideshow(this.form); this.$message.success('新增成功') }
          this.dialogVisible = false; this.loadData()
        } finally { this.submitting = false }
      })
    },
    handleDelete(row) {
      this.$confirm('确定删除此轮播图？', '提示', { type: 'warning' }).then(async () => {
        await deleteSlideshow(row.slideshowId); this.$message.success('删除成功'); this.loadData()
      }).catch(() => {})
    }
  }
}
</script>
