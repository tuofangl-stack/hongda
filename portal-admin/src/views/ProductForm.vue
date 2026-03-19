<template>
  <div>
    <div class="page-header">
      <h2>{{ isEdit ? '编辑产品' : '新增产品' }}</h2>
      <el-button @click="$router.back()">返回列表</el-button>
    </div>

    <div class="form-card">
      <el-form :model="form" :rules="rules" ref="productForm" label-width="100px">
        <el-form-item label="产品名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入产品名称" />
        </el-form-item>

        <el-form-item label="产品分类" prop="typeId">
          <el-select v-model="form.typeId" placeholder="请选择分类" style="width:100%;">
            <el-option label="家用电梯" :value="1" />
            <el-option label="别墅电梯" :value="2" />
            <el-option label="观光电梯" :value="3" />
          </el-select>
        </el-form-item>

        <el-form-item label="封面图" prop="cover">
          <el-upload
            class="upload-cover"
            :action="uploadUrl"
            :headers="uploadHeaders"
            :show-file-list="false"
            :on-success="handleCoverSuccess"
            accept="image/*"
          >
            <el-image
              v-if="form.cover"
              :src="form.cover"
              style="width:200px;height:150px;border-radius:8px;"
              fit="cover"
            />
            <div v-else style="width:200px;height:150px;border:2px dashed #dcdfe6;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#909399;cursor:pointer;">
              <div style="text-align:center;">
                <i class="el-icon-plus" style="font-size:28px;"></i>
                <div style="font-size:13px;margin-top:4px;">点击上传</div>
              </div>
            </div>
          </el-upload>
        </el-form-item>

        <el-form-item label="产品价格" prop="price">
          <el-input-number v-model="form.price" :min="0" :precision="2" :step="1000" style="width:220px;" />
          <span style="margin-left:8px;color:#909399;">元</span>
        </el-form-item>

        <el-form-item label="库存数量" prop="stock">
          <el-input-number v-model="form.stock" :min="0" style="width:220px;" />
        </el-form-item>

        <el-form-item label="产品状态">
          <el-switch v-model="statusSwitch" active-text="上架" inactive-text="下架" />
        </el-form-item>

        <el-form-item label="产品描述">
          <el-input
            v-model="form.description"
            type="textarea"
            :rows="5"
            placeholder="请输入产品描述"
          />
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="handleSubmit" :loading="submitting">
            {{ isEdit ? '保存修改' : '确认新增' }}
          </el-button>
          <el-button @click="$router.back()">取消</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import { getProduct, addProduct, updateProduct, uploadUrl, getUploadHeaders } from '@/api'

export default {
  name: 'ProductForm',
  data() {
    return {
      isEdit: false,
      submitting: false,
      uploadUrl: uploadUrl,
      uploadHeaders: getUploadHeaders(),
      form: {
        productId: null,
        name: '',
        typeId: null,
        cover: '',
        images: '',
        description: '',
        price: 0,
        stock: 0,
        status: 1,
      },
      rules: {
        name: [{ required: true, message: '请输入产品名称', trigger: 'blur' }],
        typeId: [{ required: true, message: '请选择分类', trigger: 'change' }],
        price: [{ required: true, message: '请输入价格', trigger: 'blur' }],
      }
    }
  },
  computed: {
    statusSwitch: {
      get() { return this.form.status === 1 },
      set(val) { this.form.status = val ? 1 : 0 }
    }
  },
  mounted() {
    const id = this.$route.params.id
    if (id) {
      this.isEdit = true
      this.loadProduct(id)
    }
  },
  methods: {
    async loadProduct(id) {
      const res = await getProduct(id)
      this.form = res.data
    },
    handleCoverSuccess(res) {
      if (res.code === 200) {
        this.form.cover = res.data
        this.$message.success('上传成功')
      } else {
        this.$message.error(res.message || '上传失败')
      }
    },
    handleSubmit() {
      this.$refs.productForm.validate(async valid => {
        if (!valid) return
        this.submitting = true
        try {
          if (this.isEdit) {
            await updateProduct(this.form)
            this.$message.success('修改成功')
          } else {
            await addProduct(this.form)
            this.$message.success('新增成功')
          }
          this.$router.push('/product')
        } finally {
          this.submitting = false
        }
      })
    }
  }
}
</script>
