<template>
  <div>
    <!-- 统计卡片 -->
    <div class="stat-cards">
      <div class="stat-card">
        <div class="stat-card-icon"><i class="el-icon-goods"></i></div>
        <div class="stat-card-value">{{ stats.productCount || 0 }}</div>
        <div class="stat-card-label">产品总数</div>
      </div>
      <div class="stat-card">
        <div class="stat-card-icon"><i class="el-icon-view"></i></div>
        <div class="stat-card-value">{{ stats.totalViews || 0 }}</div>
        <div class="stat-card-label">总浏览量 · 今日 {{ stats.todayViews || 0 }}</div>
      </div>
      <div class="stat-card">
        <div class="stat-card-icon"><i class="el-icon-shopping-cart-full"></i></div>
        <div class="stat-card-value">{{ stats.totalSales || 0 }}</div>
        <div class="stat-card-label">总销量</div>
      </div>
      <div class="stat-card">
        <div class="stat-card-icon"><i class="el-icon-money"></i></div>
        <div class="stat-card-value">¥{{ formatMoney(stats.totalAmount) }}</div>
        <div class="stat-card-label">总销售额 · 今日 ¥{{ formatMoney(stats.todayAmount) }}</div>
      </div>
    </div>

    <!-- 图表区 -->
    <div class="chart-row">
      <div class="chart-panel">
        <div class="chart-panel-title">浏览量趋势 (近7天)</div>
        <div ref="viewChart" style="height:300px;"></div>
      </div>
      <div class="chart-panel">
        <div class="chart-panel-title">销售额趋势 (近7天)</div>
        <div ref="saleChart" style="height:300px;"></div>
      </div>
    </div>

    <!-- 热销排行 -->
    <div class="chart-panel">
      <div class="chart-panel-title">🏆 热销产品排行 TOP 10</div>
      <div v-for="(item, index) in topProducts" :key="item.productId" class="top-product-row">
        <span
          class="top-rank"
          :class="index === 0 ? 'rank-1' : index === 1 ? 'rank-2' : index === 2 ? 'rank-3' : 'rank-other'"
        >
          {{ index + 1 }}
        </span>
        <div class="top-product-info">
          <div class="top-product-name">{{ item.name }}</div>
        </div>
        <div class="top-product-sales">{{ item.sales }} 台</div>
      </div>
      <el-empty v-if="topProducts.length === 0" description="暂无数据" />
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { getDashboardStats, getDashboardTrend, getTopProducts } from '@/api'

export default {
  name: 'Dashboard',
  data() {
    return {
      stats: {},
      topProducts: [],
      viewChartInstance: null,
      saleChartInstance: null
    }
  },
  mounted() {
    this.loadData()
  },
  beforeDestroy() {
    if (this.viewChartInstance) this.viewChartInstance.dispose()
    if (this.saleChartInstance) this.saleChartInstance.dispose()
  },
  methods: {
    async loadData() {
      try {
        const [statsRes, trendRes, topRes] = await Promise.all([
          getDashboardStats(),
          getDashboardTrend(7),
          getTopProducts()
        ])
        this.stats = statsRes.data
        this.topProducts = topRes.data || []
        this.renderCharts(trendRes.data)
      } catch (e) {
        console.error(e)
      }
    },
    renderCharts(trend) {
      // 浏览量图表
      this.viewChartInstance = echarts.init(this.$refs.viewChart)
      const viewDates = (trend.viewTrend || []).map(i => i.date)
      const viewCounts = (trend.viewTrend || []).map(i => i.count)
      this.viewChartInstance.setOption({
        tooltip: { trigger: 'axis' },
        grid: { left: 40, right: 20, top: 20, bottom: 30 },
        xAxis: { type: 'category', data: viewDates, axisLabel: { fontSize: 11 } },
        yAxis: { type: 'value', minInterval: 1 },
        series: [{
          data: viewCounts,
          type: 'line',
          smooth: true,
          areaStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
              { offset: 0, color: 'rgba(99,102,241,0.3)' },
              { offset: 1, color: 'rgba(99,102,241,0.02)' }
            ])
          },
          lineStyle: { color: '#6366f1', width: 3 },
          itemStyle: { color: '#6366f1' }
        }]
      })

      // 销售额图表
      this.saleChartInstance = echarts.init(this.$refs.saleChart)
      const saleDates = (trend.saleTrend || []).map(i => i.date)
      const saleAmounts = (trend.saleTrend || []).map(i => Number(i.amount))
      this.saleChartInstance.setOption({
        tooltip: {
          trigger: 'axis',
          formatter: params => {
            const d = params[0]
            return d.name + '<br/>销售额: ¥' + Number(d.value).toLocaleString()
          }
        },
        grid: { left: 60, right: 20, top: 20, bottom: 30 },
        xAxis: { type: 'category', data: saleDates, axisLabel: { fontSize: 11 } },
        yAxis: { type: 'value' },
        series: [{
          data: saleAmounts,
          type: 'bar',
          barWidth: 24,
          itemStyle: {
            borderRadius: [8, 8, 0, 0],
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
              { offset: 0, color: '#f59e0b' },
              { offset: 1, color: '#f97316' }
            ])
          }
        }]
      })
    },
    formatMoney(val) {
      if (!val) return '0.00'
      return Number(val).toLocaleString('zh-CN', { minimumFractionDigits: 2, maximumFractionDigits: 2 })
    }
  }
}
</script>
