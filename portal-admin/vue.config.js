module.exports = {
  pages: {
    index: {
      entry: 'src/main.js',
    }
  },
  lintOnSave: false,
  devServer: {
    port: 8086,
    proxy: {
      '/admin': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/uploads': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      }
    }
  }
}
