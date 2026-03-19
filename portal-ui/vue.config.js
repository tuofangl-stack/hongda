module.exports = {
  pages:{
    index:{
      entry:'src/main.js',
    }
  },
  lintOnSave: false,

  devServer:{
    port:8087,
    proxy: {
      '/admin': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/uploads': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/api': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/slideshow': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/type': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/article': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/designer': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/company': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/example': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      },
      '/entrance': {
        target: 'http://localhost:8888',
        changeOrigin: true,
      }
    }
  }
}
