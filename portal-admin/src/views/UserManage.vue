<template>
  <div class="user-manage">
    <!-- 搜索栏 -->
    <div class="search-bar">
      <el-input
        v-model="keyword"
        placeholder="搜索用户名/邮箱/昵称"
        prefix-icon="el-icon-search"
        clearable
        style="width: 300px; margin-right: 12px;"
        @clear="loadList"
        @keyup.enter.native="loadList"
      />
      <el-button type="primary" icon="el-icon-search" @click="loadList">搜索</el-button>
    </div>

    <!-- 用户表格 -->
    <el-table :data="userList" border stripe style="width: 100%; margin-top: 16px;" v-loading="loading">
      <el-table-column prop="userId" label="ID" width="80" />
      <el-table-column prop="username" label="用户名" width="140" />
      <el-table-column prop="email" label="邮箱" width="200" />
      <el-table-column prop="nickname" label="昵称" width="140" />
      <el-table-column prop="phone" label="手机号" width="140" />
      <el-table-column label="邮箱验证" width="100" align="center">
        <template slot-scope="{ row }">
          <el-tag :type="row.emailVerified === 1 ? 'success' : 'info'" size="small">
            {{ row.emailVerified === 1 ? '已验证' : '未验证' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" width="100" align="center">
        <template slot-scope="{ row }">
          <el-switch
            :value="row.status === 1"
            active-color="#67c23a"
            inactive-color="#f56c6c"
            @change="handleStatusChange(row)"
          />
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="注册时间" width="180" />
      <el-table-column label="操作" width="100" align="center">
        <template slot-scope="{ row }">
          <el-popconfirm title="确定删除该用户吗？" @confirm="handleDelete(row.userId)">
            <el-button slot="reference" type="text" style="color: #f56c6c;">删除</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div style="margin-top: 16px; text-align: right;">
      <el-pagination
        background
        layout="total, prev, pager, next"
        :total="total"
        :page-size="pageSize"
        :current-page.sync="currentPage"
        @current-change="loadList"
      />
    </div>
  </div>
</template>

<script>
import { getUserList, updateUserStatus, deleteUser } from '../api'

export default {
  name: 'UserManage',
  data() {
    return {
      userList: [],
      keyword: '',
      loading: false,
      currentPage: 1,
      pageSize: 10,
      total: 0
    }
  },
  created() {
    this.loadList()
  },
  methods: {
    async loadList() {
      this.loading = true
      try {
        const res = await getUserList({
          page: this.currentPage,
          size: this.pageSize,
          keyword: this.keyword || undefined
        })
        this.userList = res.data.records
        this.total = Number(res.data.total)
      } catch (e) {
        console.error(e)
      } finally {
        this.loading = false
      }
    },
    async handleStatusChange(row) {
      const newStatus = row.status === 1 ? 0 : 1
      const action = newStatus === 0 ? '禁用' : '启用'
      try {
        await this.$confirm(`确定${action}用户 "${row.username}" 吗？`, '提示', { type: 'warning' })
        await updateUserStatus({ userId: row.userId, status: newStatus })
        this.$message.success(`已${action}`)
        this.loadList()
      } catch (e) {
        // cancelled or error
      }
    },
    async handleDelete(id) {
      try {
        await deleteUser(id)
        this.$message.success('删除成功')
        this.loadList()
      } catch (e) {
        console.error(e)
      }
    }
  }
}
</script>

<style scoped>
.user-manage {
  padding: 0;
}
.search-bar {
  display: flex;
  align-items: center;
}
</style>
