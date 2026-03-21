<template>
  <div class="category-page">
    <!-- Page Header -->
    <div class="cat-page-header">
      <div>
        <h2 class="cat-page-title">产品分类管理</h2>
        <p class="cat-page-subtitle">管理产品中心的所有分类</p>
      </div>
      <el-button class="cat-add-btn" @click="openAdd">
        <i class="el-icon-plus"></i> 新建分类
      </el-button>
    </div>

    <!-- Category List Card -->
    <div class="cat-card">
      <div class="cat-list" v-if="categories.length > 0">
        <div
          class="cat-item"
          v-for="(item, idx) in categories"
          :key="item.typeId"
        >
          <div class="cat-item__left">
            <div class="cat-item__index">{{ idx + 1 }}</div>
            <div class="cat-item__info">
              <span class="cat-item__name">{{ item.typeName }}</span>
              <span class="cat-item__meta">ID: {{ item.typeId }} · {{ item.createTime || '—' }}</span>
            </div>
          </div>
          <div class="cat-item__actions">
            <button class="cat-btn cat-btn--edit" @click="openEdit(item)" title="编辑">
              <i class="el-icon-edit"></i>
            </button>
            <button class="cat-btn cat-btn--delete" @click="handleDelete(item)" title="删除">
              <i class="el-icon-delete"></i>
            </button>
          </div>
        </div>
      </div>

      <div class="cat-empty" v-else>
        <i class="el-icon-folder-opened"></i>
        <p>暂无分类，点击上方按钮添加</p>
      </div>
    </div>

    <!-- Add/Edit Dialog -->
    <el-dialog
      :title="editMode ? '编辑分类' : '新建分类'"
      :visible.sync="dialogVisible"
      width="480px"
      class="cat-dialog"
      :close-on-click-modal="false"
      append-to-body
    >
      <el-form :model="form" ref="form" label-width="80px" class="cat-form">
        <el-form-item label="分类名称" prop="typeName">
          <el-input
            v-model="form.typeName"
            placeholder="例如：基站天线部件/Base Station Antenna Parts"
            maxlength="100"
            show-word-limit
            clearable
          ></el-input>
          <div class="cat-form-tip">
            支持双语格式：中文名/English Name（用 / 分隔）
          </div>
        </el-form-item>
      </el-form>
      <div slot="footer" class="cat-dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button class="cat-save-btn" :loading="saving" @click="handleSave">
          {{ editMode ? '保存修改' : '创建分类' }}
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getCategoryList, addCategory, updateCategory, deleteCategory } from '@/api'

export default {
  name: 'Category',
  data() {
    return {
      categories: [],
      dialogVisible: false,
      editMode: false,
      saving: false,
      form: {
        typeId: null,
        typeName: ''
      }
    }
  },
  mounted() {
    this.loadCategories()
  },
  methods: {
    async loadCategories() {
      try {
        const res = await getCategoryList()
        this.categories = res.data || []
      } catch (e) {
        console.error('加载分类失败', e)
      }
    },
    openAdd() {
      this.editMode = false
      this.form = { typeId: null, typeName: '' }
      this.dialogVisible = true
    },
    openEdit(item) {
      this.editMode = true
      this.form = { typeId: item.typeId, typeName: item.typeName }
      this.dialogVisible = true
    },
    async handleSave() {
      if (!this.form.typeName.trim()) {
        this.$message.warning('请输入分类名称')
        return
      }
      this.saving = true
      try {
        if (this.editMode) {
          await updateCategory(this.form)
          this.$message.success('修改成功')
        } else {
          await addCategory(this.form)
          this.$message.success('创建成功')
        }
        this.dialogVisible = false
        this.loadCategories()
      } catch (e) {
        console.error(e)
      } finally {
        this.saving = false
      }
    },
    handleDelete(item) {
      this.$confirm(`确定删除分类「${item.typeName}」？删除后该分类下的产品将失去归类。`, '确认删除', {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        type: 'warning',
        confirmButtonClass: 'cat-confirm-delete-btn'
      }).then(async () => {
        try {
          await deleteCategory(item.typeId)
          this.$message.success('已删除')
          this.loadCategories()
        } catch (e) {
          console.error(e)
        }
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.category-page {
  max-width: 800px;
}

/* ====== Page Header ====== */
.cat-page-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 24px;
}

.cat-page-title {
  font-size: 22px;
  font-weight: 600;
  color: #202124;
  margin: 0 0 4px 0;
  letter-spacing: -0.2px;
}

.cat-page-subtitle {
  font-size: 14px;
  color: #5f6368;
  margin: 0;
}

.cat-add-btn {
  background: #1a73e8 !important;
  color: #fff !important;
  border: none !important;
  border-radius: 24px !important;
  padding: 10px 24px !important;
  font-size: 14px !important;
  font-weight: 500 !important;
  box-shadow: 0 1px 3px rgba(26, 115, 232, 0.3), 0 4px 8px rgba(26, 115, 232, 0.15) !important;
  transition: all 0.2s ease !important;
}

.cat-add-btn:hover {
  background: #1765cc !important;
  box-shadow: 0 2px 6px rgba(26, 115, 232, 0.4), 0 6px 16px rgba(26, 115, 232, 0.2) !important;
  transform: translateY(-1px);
}

.cat-add-btn i {
  margin-right: 6px;
  font-weight: 700;
}

/* ====== Card ====== */
.cat-card {
  background: #fff;
  border-radius: 12px;
  border: 1px solid #e8eaed;
  overflow: hidden;
}

/* ====== List Items ====== */
.cat-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 24px;
  border-bottom: 1px solid #f1f3f4;
  transition: background 0.15s ease;
}

.cat-item:last-child {
  border-bottom: none;
}

.cat-item:hover {
  background: #f8f9fa;
}

.cat-item__left {
  display: flex;
  align-items: center;
  gap: 16px;
  min-width: 0;
  flex: 1;
}

.cat-item__index {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: #e8f0fe;
  color: #1a73e8;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 600;
  flex-shrink: 0;
}

.cat-item__info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  min-width: 0;
}

.cat-item__name {
  font-size: 14px;
  font-weight: 500;
  color: #202124;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.cat-item__meta {
  font-size: 12px;
  color: #9aa0a6;
}

.cat-item__actions {
  display: flex;
  gap: 4px;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.cat-item:hover .cat-item__actions {
  opacity: 1;
}

/* ====== Action Buttons ====== */
.cat-btn {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  border: none;
  background: transparent;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  transition: all 0.15s ease;
}

.cat-btn--edit {
  color: #5f6368;
}

.cat-btn--edit:hover {
  background: #e8f0fe;
  color: #1a73e8;
}

.cat-btn--delete {
  color: #5f6368;
}

.cat-btn--delete:hover {
  background: #fce8e6;
  color: #d93025;
}

/* ====== Empty State ====== */
.cat-empty {
  padding: 80px 24px;
  text-align: center;
  color: #9aa0a6;
}

.cat-empty i {
  font-size: 48px;
  margin-bottom: 12px;
  display: block;
}

.cat-empty p {
  font-size: 14px;
  margin: 0;
}

/* ====== Dialog ====== */
.cat-form-tip {
  font-size: 12px;
  color: #9aa0a6;
  margin-top: 4px;
  line-height: 1.5;
}

.cat-save-btn {
  background: #1a73e8 !important;
  color: #fff !important;
  border: none !important;
  border-radius: 6px !important;
  font-weight: 500 !important;
}

.cat-save-btn:hover {
  background: #1765cc !important;
}

.cat-dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
}
</style>

<style>
/* Global dialog overrides for Material feel */
.cat-dialog .el-dialog {
  border-radius: 12px !important;
  box-shadow: 0 8px 30px rgba(0,0,0,0.12), 0 2px 8px rgba(0,0,0,0.06) !important;
}

.cat-dialog .el-dialog__header {
  padding: 20px 24px 12px;
  border-bottom: none;
}

.cat-dialog .el-dialog__title {
  font-size: 18px;
  font-weight: 600;
  color: #202124;
}

.cat-dialog .el-dialog__body {
  padding: 8px 24px 16px;
}

.cat-dialog .el-dialog__footer {
  padding: 12px 24px 20px;
  border-top: none;
}

.cat-confirm-delete-btn {
  background: #d93025 !important;
  border-color: #d93025 !important;
}

.cat-confirm-delete-btn:hover {
  background: #c5221f !important;
  border-color: #c5221f !important;
}
</style>
