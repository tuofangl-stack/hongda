<template>
  <div class="login-container">
    <div class="login-card">
      <h1 class="login-title">后台管理系统</h1>
      <p class="login-subtitle">PORTAL ADMIN SYSTEM</p>
      <el-form :model="form" :rules="rules" ref="loginForm" @submit.native.prevent="handleLogin">
        <el-form-item prop="username">
          <el-input
            v-model="form.username"
            placeholder="请输入用户名"
            prefix-icon="el-icon-user"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="form.password"
            type="password"
            placeholder="请输入密码"
            prefix-icon="el-icon-lock"
            show-password
          />
        </el-form-item>
        <el-form-item>
          <button
            class="login-btn"
            type="submit"
            :disabled="loading"
          >
            {{ loading ? '登 录 中...' : '登 录' }}
          </button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import { login } from '@/api'

export default {
  name: 'Login',
  data() {
    return {
      form: {
        username: '',
        password: ''
      },
      rules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
      },
      loading: false
    }
  },
  methods: {
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (!valid) return
        this.loading = true
        login(this.form).then(res => {
          localStorage.setItem('admin_token', res.data.token)
          localStorage.setItem('admin_nickname', res.data.nickname || res.data.username)
          this.$message.success('登录成功')
          this.$router.push('/dashboard')
        }).catch(() => {
          this.loading = false
        })
      })
    }
  }
}
</script>
