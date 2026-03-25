<template>
  <div class="login-page">
    <div class="login-container">
      <!-- Logo & Title -->
      <div class="login-header">
        <h1>鸿达制冷</h1>
        <p>{{ isLogin ? '欢迎回来，请登录您的账号' : '创建新账号，注册后即可使用' }}</p>
      </div>

      <!-- 登录表单 -->
      <div v-if="isLogin" class="login-form">
        <el-form :model="loginForm" :rules="loginRules" ref="loginFormRef">
          <el-form-item prop="account">
            <el-input
              v-model="loginForm.account"
              placeholder="用户名 / 邮箱"
              prefix-icon="el-icon-user"
              size="large"
            />
          </el-form-item>
          <el-form-item prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              placeholder="密码"
              prefix-icon="el-icon-lock"
              size="large"
              show-password
              @keyup.enter.native="handleLogin"
            />
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              :loading="loading"
              style="width: 100%;"
              size="large"
              @click="handleLogin"
            >登 录</el-button>
          </el-form-item>
        </el-form>
        <div class="switch-mode">
          还没有账号？<a href="javascript:;" @click="isLogin = false">立即注册</a>
        </div>
      </div>

      <!-- 注册表单 -->
      <div v-else class="login-form">
        <el-form :model="registerForm" :rules="registerRules" ref="registerFormRef">
          <el-form-item prop="username">
            <el-input
              v-model="registerForm.username"
              placeholder="用户名（3-20个字符）"
              prefix-icon="el-icon-user"
              size="large"
            />
          </el-form-item>
          <el-form-item prop="email">
            <el-input
              v-model="registerForm.email"
              placeholder="邮箱"
              prefix-icon="el-icon-message"
              size="large"
            />
          </el-form-item>
          <el-form-item prop="code">
            <div style="display: flex; gap: 10px;">
              <el-input
                v-model="registerForm.code"
                placeholder="邮箱验证码"
                prefix-icon="el-icon-key"
                size="large"
                style="flex: 1;"
              />
              <el-button
                size="large"
                :disabled="codeCooldown > 0"
                :loading="sendingCode"
                @click="handleSendCode"
              >{{ codeCooldown > 0 ? codeCooldown + 's' : '发送验证码' }}</el-button>
            </div>
          </el-form-item>
          <el-form-item prop="password">
            <el-input
              v-model="registerForm.password"
              type="password"
              placeholder="密码（至少6位）"
              prefix-icon="el-icon-lock"
              size="large"
              show-password
            />
          </el-form-item>
          <el-form-item prop="confirmPassword">
            <el-input
              v-model="registerForm.confirmPassword"
              type="password"
              placeholder="确认密码"
              prefix-icon="el-icon-lock"
              size="large"
              show-password
              @keyup.enter.native="handleRegister"
            />
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              :loading="loading"
              style="width: 100%;"
              size="large"
              @click="handleRegister"
            >注 册</el-button>
          </el-form-item>
        </el-form>
        <div class="switch-mode">
          已有账号？<a href="javascript:;" @click="isLogin = true">立即登录</a>
        </div>
      </div>

      <div class="back-home">
        <router-link to="/">← 返回首页</router-link>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'UserLogin',
  data() {
    const validateConfirm = (rule, value, callback) => {
      if (value !== this.registerForm.password) {
        callback(new Error('两次密码不一致'))
      } else {
        callback()
      }
    }
    return {
      isLogin: true,
      loading: false,
      sendingCode: false,
      codeCooldown: 0,
      codeCooldownTimer: null,
      loginForm: {
        account: '',
        password: ''
      },
      registerForm: {
        username: '',
        email: '',
        code: '',
        password: '',
        confirmPassword: ''
      },
      loginRules: {
        account: [{ required: true, message: '请输入用户名或邮箱', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
      },
      registerRules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 20, message: '用户名长度在3-20个字符之间', trigger: 'blur' }
        ],
        email: [
          { required: true, message: '请输入邮箱', trigger: 'blur' },
          { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
        ],
        code: [{ required: true, message: '请输入验证码', trigger: 'blur' }],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 6, message: '密码至少6位', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '请确认密码', trigger: 'blur' },
          { validator: validateConfirm, trigger: 'blur' }
        ]
      }
    }
  },
  beforeDestroy() {
    if (this.codeCooldownTimer) {
      clearInterval(this.codeCooldownTimer)
    }
  },
  methods: {
    async handleLogin() {
      this.$refs.loginFormRef.validate(async (valid) => {
        if (!valid) return
        this.loading = true
        try {
          const res = await axios.post('/api/user/login', this.loginForm)
          if (res.data.code === 200) {
            const data = res.data.data
            localStorage.setItem('user_token', data.token)
            localStorage.setItem('user_nickname', data.nickname || data.username)
            this.$message.success('登录成功')
            this.$router.push('/')
          } else {
            this.$message.error(res.data.message || '登录失败')
          }
        } catch (e) {
          this.$message.error(e.response?.data?.message || '网络错误')
        } finally {
          this.loading = false
        }
      })
    },
    async handleSendCode() {
      if (!this.registerForm.email) {
        this.$message.warning('请先输入邮箱')
        return
      }
      this.sendingCode = true
      try {
        const res = await axios.post('/api/user/sendCode', {
          email: this.registerForm.email,
          type: 1
        })
        if (res.data.code === 200) {
          this.$message.success('验证码已发送到您的邮箱')
          // 开始倒计时
          this.codeCooldown = 60
          this.codeCooldownTimer = setInterval(() => {
            this.codeCooldown--
            if (this.codeCooldown <= 0) {
              clearInterval(this.codeCooldownTimer)
            }
          }, 1000)
        } else {
          this.$message.error(res.data.message || '发送失败')
        }
      } catch (e) {
        this.$message.error(e.response?.data?.message || '发送失败')
      } finally {
        this.sendingCode = false
      }
    },
    async handleRegister() {
      this.$refs.registerFormRef.validate(async (valid) => {
        if (!valid) return
        this.loading = true
        try {
          const res = await axios.post('/api/user/register', {
            username: this.registerForm.username,
            email: this.registerForm.email,
            code: this.registerForm.code,
            password: this.registerForm.password
          })
          if (res.data.code === 200) {
            this.$message.success('注册成功，请登录')
            this.isLogin = true
            // 自动填充用户名
            this.loginForm.account = this.registerForm.username
          } else {
            this.$message.error(res.data.message || '注册失败')
          }
        } catch (e) {
          this.$message.error(e.response?.data?.message || '注册失败')
        } finally {
          this.loading = false
        }
      })
    }
  }
}
</script>

<style scoped>
.login-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
}

.login-container {
  width: 420px;
  background: #fff;
  border-radius: 16px;
  padding: 40px 36px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
}

.login-header {
  text-align: center;
  margin-bottom: 30px;
}

.login-header h1 {
  font-size: 28px;
  font-weight: 700;
  color: #303133;
  margin: 0 0 8px 0;
}

.login-header p {
  font-size: 14px;
  color: #909399;
  margin: 0;
}

.login-form {
  margin-top: 10px;
}

.switch-mode {
  text-align: center;
  margin-top: 16px;
  font-size: 14px;
  color: #909399;
}

.switch-mode a {
  color: #667eea;
  text-decoration: none;
  font-weight: 500;
}

.switch-mode a:hover {
  text-decoration: underline;
}

.back-home {
  text-align: center;
  margin-top: 20px;
}

.back-home a {
  color: #909399;
  font-size: 13px;
  text-decoration: none;
}

.back-home a:hover {
  color: #667eea;
}

/* 深度样式覆盖 */
.login-form >>> .el-input__inner {
  border-radius: 8px;
  height: 44px;
  line-height: 44px;
}

.login-form >>> .el-button--primary {
  border-radius: 8px;
  height: 44px;
  font-size: 16px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: none;
}

.login-form >>> .el-button--primary:hover {
  opacity: 0.9;
}
</style>
