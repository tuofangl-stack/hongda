<template>
	<Layout>
		<div  style="width: 100%">
			<div class="index-page">
				<div data-am-widget="tabs" class="am-tabs am-tabs-default">
					<div class="am-tabs-bd">
						<div
							class="am-tab-panel am-active"
							v-if="slideshow.length > 0"
							:style="{ backgroundImage: `url(${slideshow[tabIndex].imageUrl})`}">
							<div class="index-banner">
								<div class="index-mask">
									<div class="container">
										<div class="am-g">
											<div class="am-u-md-10 am-u-sm-centered" style="text-align: center">
												<h1 class="slide_simple--title">专注精神和精湛工艺</h1>
												<p class="slide_simple--text am-text-left" style="display: flex;justify-content: center">
                          年产能达到800万套，产值2400万元，人均产值高达63万元，用最小规模把汽车空调铜件做到极致，形成小而专的立身之本。
                        </p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					</div>
			</div>
		</div>

		<div class="section">
			<div class="container" style="max-width: 1160px;">
				<div class="section--header">
					<h2 class="section--title">核心优势</h2>
					<p class="section--description">
						全球领先HTML5企业移动化解决方案供应商，由前微软美国总部IE浏览器核心研发团队成员及移动互联网行业专家在美国西雅图创立,获得了微软创投的扶持以及晨兴资本、IDG资本、天创资本等国际顶级风投机构的投资。
					</p>
				</div>

				<div class="index-container">
					<div class="am-g">
						<div class="am-u-md-3" v-for="(advantage,index) in advantageList" :key="index">
							<div class="features_item">
								<img :src="advantage.cover" alt="">
								<h3 class="features_item--title">{{advantage.title}}</h3>
								<p class="features_item--text">{{advantage.desc}}</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="section" style="border-bottom: 1px solid #e9e9e9; padding-top: 0">
			<div class="container" style="max-width: 1160px;">
				<div class="section--header">
					<h2 class="section--title">我们的服务</h2>
					<p class="section--description">
						全球领先HTML5企业移动化解决方案供应商，由前微软美国总部IE浏览器核心研发团队成员及移动互联网行业专家在美国西雅图创立
						<br>获得了微软创投的扶持以及晨兴资本、IDG资本、天创资本等国际顶级风投机构的投资。
					</p>
				</div>

				<div class="index-container">
					<div class="am-g">
						<div class="am-u-md-3" v-for="(service,index) in serviceList" :key="index">
							<div class="service_item">
								<i class="service_item--icon" :class="service.icon"></i>
								<h3 class="service_item--title">{{ service.title }}</h3>
								<div class="service_item--text"><p>{{service.desc}}</p></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</Layout>
</template>

<script>
import Layout from "@/components/common/Layout";
export default {
	name: "IndexView",
	components: {Layout},
	data(){
		return{
			tabIndex: 0,
			slideshow:[],

			advantageList:[
				{id:1,cover:require('../assets/images/index/f01.jpg'),title:'简单的适配过程',desc:'用户可快速学习适配开发，通过丰富的组件库完成页面功能的移动化适配。'},
				{id:2,cover:require('../assets/images/index/f01.jpg'),title:'简单的适配过程',desc:'用户可快速学习适配开发，通过丰富的组件库完成页面功能的移动化适配。'},
				{id:3,cover:require('../assets/images/index/f01.jpg'),title:'简单的适配过程',desc:'用户可快速学习适配开发，通过丰富的组件库完成页面功能的移动化适配。'},
				{id:4,cover:require('../assets/images/index/f01.jpg'),title:'简单的适配过程',desc:'用户可快速学习适配开发，通过丰富的组件库完成页面功能的移动化适配。'},
			],
			serviceList:[
				{id:1,icon:'am-icon-diamond',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'},
				{id:2,icon:'am-icon-user',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'},
				{id:3,icon:'am-icon-umbrella',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'},
				{id:4,icon:'am-icon-briefcase',title:'多页面工作',desc:'标签栏可切换，不必为了新内容而被迫跳转界面，多项工作内容并行处理'}
			]
		}
	},
	mounted() {
		this.getSlideshow()
	},
	methods:{
		getSlideshow(){
			this.getRequest("/findAllSlideshow").then(resp =>{
				if (resp){
					this.slideshow = resp.data.data
					//console.log(this.slideshow)
				}
			})
		}
	},
}
</script>

<style scoped>

</style>
